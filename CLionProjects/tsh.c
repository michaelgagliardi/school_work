/* 
 * tsh - A tiny shell program with job control
 * 
 * <Michael Gagliardi and Zachary Grimes>
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <ctype.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <fcntl.h>

/* Misc manifest constants */
#define MAXLINE    1024   /* max line size */
#define MAXARGS     128   /* max args on a command line */
#define MAXJOBS      16   /* max jobs at any point in time */
#define MAXJID    1<<16   /* max job ID */

/* Job states */
#define UNDEF 0 /* undefined */
#define FG 1    /* running in foreground */
#define BG 2    /* running in background */
#define ST 3    /* stopped */

/* 
 * Jobs states: FG (foreground), BG (background), ST (stopped)
 * Job state transitions and enabling actions:
 *     FG -> ST  : ctrl-z
 *     ST -> FG  : fg command
 *     ST -> BG  : bg command
 *     BG -> FG  : fg command
 * At most 1 job can be in the FG state.
 */

/* Global variables */
extern char **environ;      /* defined in libc */
char prompt[] = "tsh> ";    /* command line prompt (DO NOT CHANGE) */
int verbose = 0;            /* if true, print additional output */
int nextjid = 1;            /* next job ID to allocate */
char sbuf[MAXLINE];         /* for composing sprintf messages */

struct job_t {              /* The job struct */
    pid_t pid;              /* job PID */
    int jid;                /* job ID [1, 2, ...] */
    int state;              /* UNDEF, BG, FG, or ST */
    char cmdline[MAXLINE];  /* command line */
};
struct job_t jobs[MAXJOBS]; /* The job list */
/* End global variables */


/* Function prototypes */

/* Here are the functions that you will implement */
void eval(char *cmdline);
int builtin_cmd(char **argv, char *cmdline);
void do_bgfg(char **argv);
void waitfg(pid_t pid);

void sigchld_handler(int sig);
void sigtstp_handler(int sig);
void sigint_handler(int sig);

/* Here are helper routines that we've provided for you */
int parseline(const char *cmdline, char **argv); 
void sigquit_handler(int sig);

void clearjob(struct job_t *job);
void initjobs(struct job_t *jobs);
int maxjid(struct job_t *jobs); 
int addjob(struct job_t *jobs, pid_t pid, int state, char *cmdline);
int deletejob(struct job_t *jobs, pid_t pid); 
pid_t fgpid(struct job_t *jobs);
struct job_t *getjobpid(struct job_t *jobs, pid_t pid);
struct job_t *getjobjid(struct job_t *jobs, int jid); 
int pid2jid(pid_t pid); 
void listjobs(struct job_t *jobs);

void usage(void);
void unix_error(char *msg);
void app_error(char *msg);
typedef void handler_t(int);
handler_t *Signal(int signum, handler_t *handler);

/*
 * main - The shell's main routine 
 */
int main(int argc, char **argv) 
{
    char c;
    char cmdline[MAXLINE];
    int emit_prompt = 1; /* emit prompt (default) */

    /* Redirect stderr to stdout (so that driver will get all output
     * on the pipe connected to stdout) */
    dup2(1, 2);

    /* Parse the command line */
    while ((c = getopt(argc, argv, "hvp")) != EOF) {
        switch (c) {
        case 'h':             /* print help message */
            usage();
	    break;
        case 'v':             /* emit additional diagnostic info */
            verbose = 1;
	    break;
        case 'p':             /* don't print a prompt */
            emit_prompt = 0;  /* handy for automatic testing */
	    break;
	default:
            usage();
	}
    }

    /* Install the signal handlers */

    /* These are the ones you will need to implement */
    Signal(SIGINT,  sigint_handler);   /* ctrl-c */
    Signal(SIGTSTP, sigtstp_handler);  /* ctrl-z */
    Signal(SIGCHLD, sigchld_handler);  /* Terminated or stopped child */

    /* This one provides a clean way to kill the shell */
    Signal(SIGQUIT, sigquit_handler); 

    /* Initialize the job list */
    initjobs(jobs);

    /* Execute the shell's read/eval loop */
    while (1) {

	/* Read command line */
	if (emit_prompt) {
	    printf("%s", prompt);
	    fflush(stdout);
	}
	if ((fgets(cmdline, MAXLINE, stdin) == NULL) && ferror(stdin))
	    app_error("fgets error");
	if (feof(stdin)) { /* End of file (ctrl-d) */
	    fflush(stdout);
	    exit(0);
	}

	/* Evaluate the command line */
	eval(cmdline);
	fflush(stdout);
	fflush(stdout);
    } 

    exit(0); /* control never reaches here */
}
  
/* 
 * eval - Evaluate the command line that the user has just typed in
 * 
 * If the user has requested a built-in command (quit, jobs, bg or fg)
 * then execute it immediately. Otherwise, fork a child process and
 * run the job in the context of the child. If the job is running in
 * the foreground, wait for it to terminate and then return.  Note:
 * each child process must have a unique process group ID so that our
 * background children don't receive SIGINT (SIGTSTP) from the kernel
 * when we type ctrl-c (ctrl-z) at the keyboard.  
*/
void eval(char *cmdline)
{
char *argv[MAXARGS]; // Argument list execve() //
    char buf[MAXLINE];   // Holds modified command line //
    int bg;              // Should the job run in bg or fg? //
    pid_t pid;           // Process id //
    sigset_t mask;

    strcpy(buf, cmdline);
    bg = parseline(buf, argv);
    if (argv[0] == NULL)
        return;   // Ignore empty lines //

    if (!builtin_cmd(argv,buf)) {
        sigemptyset(&mask);
        sigaddset(&mask,SIGCHLD);
        sigprocmask(SIG_BLOCK, &mask,NULL);
        if ((pid = fork()) == 0) { // Child runs user job //
            setpgrp();
            sigprocmask(SIG_UNBLOCK, &mask,NULL);
            if (execve(argv[0], argv, environ) < 0) {
                printf("%s: Command not found.\n", argv[0]);
                exit(0);
            }
        }

        // Parent waits for foreground job to terminate //
        if (!bg) {
            int status;
            if (waitpid(pid, &status, 0) < 0)
                unix_error("waitfg: waitpid error");
            if (addjob(jobs, pid, FG, cmdline)) { //If job is added successfully
                sigprocmask(SIG_UNBLOCK, &mask,NULL); // mask remains unset, disallows SIGKILL or SIGSTOP to be block
                waitfg(pid);//waits until foreground task is done
            } else { kill(-pid, SIGINT); };
        }
        else{
            if (addjob(jobs, pid, BG, cmdline)) {
                sigprocmask(SIG_UNBLOCK, &mask,NULL);
                printf("[%d] (%d) %s", pid2jid(pid), pid, cmdline);
            }
            else {kill(-pid,SIGINT);}
        }
    }

    return;
}

/* 
 * parseline - Parse the command line and build the argv array.
 * 
 * Characters enclosed in single quotes are treated as a single
 * argument.  Return true if the user has requested a BG job, false if
 * the user has requested a FG job.  
 */
int parseline(const char *cmdline, char **argv) 
{
    static char array[MAXLINE]; /* holds local copy of command line */
    char *buf = array;          /* ptr that traverses command line */
    char *delim;                /* points to first space delimiter */
    int argc;                   /* number of args */
    int bg;                     /* background job? */

    strcpy(buf, cmdline);
    buf[strlen(buf)-1] = ' ';  /* replace trailing '\n' with space */
    while (*buf && (*buf == ' ')) /* ignore leading spaces */
	buf++;

    /* Build the argv list */
    argc = 0;
    if (*buf == '\'') {
	buf++;
	delim = strchr(buf, '\'');
    }
    else {
	delim = strchr(buf, ' ');
    }

    while (delim) {
	argv[argc++] = buf;
	*delim = '\0';
	buf = delim + 1;
	while (*buf && (*buf == ' ')) /* ignore spaces */
	       buf++;

	if (*buf == '\'') {
	    buf++;
	    delim = strchr(buf, '\'');
	}
	else {
	    delim = strchr(buf, ' ');
	}
    }
    argv[argc] = NULL;
    
    if (argc == 0)  /* ignore blank line */
	return 1;

    /* should the job run in the background? */
    if ((bg = (*argv[argc-1] == '&')) != 0) {
	argv[--argc] = NULL;
    }
    return bg;
}

/* 
 * builtin_cmd - If the user has typed a built-in command then execute
 *    it immediately.  
 */
int reader(char **argv, char s[]){ //read input and determine if input or output redirect is called
    int count,i = 0;
    while(argv[i] != NULL){ //while there are still characters in input
        if(strstr(argv[i], s)){ //if current character matches one of the key characters
            count += 1;} //increase count by 1
        i += 1;} //move to next character in cmdline
    return count;
}

int builtin_cmd(char **argv, char *cmdline)
{
    if (!strcmp(argv[0], "quit")){ //quit
        exit(0);                   //exits, no return necessary
    }
    if(!strcmp(argv[0], "jobs")){ //executes list jobs
        listjobs(jobs);
        return 1;               //return 1 since built-in command
    }
    if(!strcmp(argv[0], "fg")){ //executes do_bgfg if fg is entered in command line
        do_bgfg(argv);
        return 1;               //return 1 since built in command
    }
    if(!strcmp(argv[0], "bg")){ //executes do_bgfg if bg is entered in command line
        do_bgfg(argv);
        return 1;               //return 1 since built in command
    }
    //return 0;                   //if not built-in command, return 0
    else if((reader(argv, ">") != 0) || (reader(argv, "<") != 0)){
        char *parray[256]; //initialize array of pointers
        char *cmd[256]; //array of pointers for commands
        int a,b,c,d = 0; //variables to be used in iterating


        while(argv[c] != NULL){ //while argument isnt empty
            if (strstr(argv[c],">") || strstr(argv[c], "<")){ //check for command tokens
                parray[d] = argv[c]; //set pointer array
                parray[++d] = c; //log index
                d+=1; //iterate to next space
            }
            c++; //move to next char in argv
        }
        parray[d] = NULL;

        while (!strstr(argv[a],">") || !strstr(argv[a], "<")) {   // if only first command is needed
            cmd[b] = argv[a]; //set command pointer and iterate through argument
            a++;
            if (argv[a] == NULL) { //if argument is empty break
                break;
            }
            b++; //move to next command pointer space
        }
        cmd[--b] = NULL; // set command for execution
        int counter, outid, inid = 0; //set id's and counter to 0
        int output2; //initialize output
        int input2; //initialize input

        while(parray[counter] != NULL){ //while the pointer array isnt empty
            if(isdigit(parray[counter][0])){ //checks to see if command is '2>'
                outid = 2; //sets output id to 2 (error)
                output2 = open(argv[(int)parray[counter+1] + 1], O_WRONLY|O_CREAT, 0777);      // open/create file and link to stdout with full permissions
            }else if(!strcmp(parray[counter], ">>")){    //checks if command is '>>' (append)
                outid = 1; //sets output id
                output2 = open(argv[(int)parray[counter+1] + 1], O_WRONLY|O_CREAT|O_APPEND, 0777);   // open/create file and link to stdout with full permissions
            }else if(!strcmp(parray[counter], ">")){    // checks if command is changing stdout
                outid = 1; //sets output id
                output2 = open(argv[(int)parray[counter+1] + 1], O_WRONLY|O_CREAT| O_TRUNC, 0777);    // open/create file and link to stdout with full permissions
            }else if(!strcmp(parray[counter], "<")){ //checks if command is changing stdin
                inid = 1; //sets input id
                input2 = open(argv[(int)parray[counter+1] + 1], O_RDONLY, 777);   // open file and send to stdin
            }
            counter += 2; //move to next command index
        }
        int stop = 0;
        if(outid >= 1){ //if linked to stdout or stderror
            close(outid);  // close stdout
            dup(output2);
        }
        if(inid == 1){ //if linked to stdin
            int s;
            pid_t pid;
            if((pid = fork()) == 0){
                close(0);
                dup2(input2, STDIN_FILENO);
                execlp(argv[0], argv[0], (char *)0);
            }
            waitpid(pid, &s, 0);
            stop = 1;
        }
        if(outid >= 1 && !stop){
            if (fork() == 0) {
                if(execvp(cmd[0], cmd) < 0){
                    printf("%s: Command not found. \n", argv[0]);
                }
                exit(1);
            }
        }
        if(outid == 2){
            close(output2);
            dup2(outid, STDERR_FILENO);
        }
        if(outid == 1){
            close(output2);
            dup2(2,1);
        }
        if(inid == 1){
            close(input2);
            dup2(0, STDIN_FILENO);
        }
        return 1;
    }
    else if(reader(argv, "|") != 0){    //if piping is called
        int i = 0; //variables for iterating
        int j = 0;
        int k = 0;
        int l = 0;
        int temp = 0;
        int end = 0;
        int pipe1[2]; //pipe 1
        int pipe2[2]; //pipe 2
        char *cmd[256]; //command pointer array
        pid_t pid; //process id

        while (argv[l] != NULL){ //while the arg is not empty
            if (strcmp(argv[l],"|") == 0){ //if argv[l] is the pipe
                temp++; //count the number of pipes
            }
            l++; //move to next character in argv
        }
        temp++; //since in this else if, theres always at least 1 pipe

        while (argv[j] != NULL && end != 1){ //while arg is not empty
            k = 0;
            // populate the command array for each iteration; formatting for exec
            while (strcmp(argv[j],"|") != 0){
                cmd[k] = argv[j];
                j++;
                if (argv[j] == NULL){
                    end = 1;
                    k++;
                    break;
                }
                k++;
            }
            cmd[k] = NULL;
            j++;
            if (i % 2 != 0){
                pipe(pipe1);
            }else{
                pipe(pipe2);
            }

            if((pid = fork()) < 0){
                printf("%s\n", "Forking Issue");
                return 0;
            }

            if(pid==0){
                if (i == 0){
                    dup2(pipe2[1], STDOUT_FILENO);
                }
                else if (i == temp - 1){
                    if (temp % 2 != 0){
                        dup2(pipe1[0],STDIN_FILENO);
                    }else{
                        dup2(pipe2[0],STDIN_FILENO);
                    }
                }else{
                    if (i % 2 != 0){
                        dup2(pipe2[0],STDIN_FILENO);
                        dup2(pipe1[1],STDOUT_FILENO);
                    }else{
                        dup2(pipe1[0],STDIN_FILENO);
                        dup2(pipe2[1],STDOUT_FILENO);
                    }
                }

                if (execvp(cmd[0],cmd) < 0){
                    kill(getpid(),SIGTERM);
                }
            }

            if (i == 0){
                close(pipe2[1]);
            }
            else if (i == temp - 1){
                if (temp % 2 != 0){
                    close(pipe1[0]);
                }else{
                    close(pipe2[0]);
                }
            }else{
                if (i % 2 != 0){
                    close(pipe2[0]);
                    close(pipe1[1]);
                }else{
                    close(pipe1[0]);
                    close(pipe2[1]);
                }
            }

            waitpid(pid,NULL,0);

            i++;
        }
        return 1;
    } else {
        return 0;
    }
}

/* 
 * do_bgfg - Execute the builtin bg and fg commands
 */
void do_bgfg(char **argv)
{
    struct job_t *p = NULL;	// initialize pointer of struct job_t to be NULL 
    char *id = argv[1];		// initialize id to be argv[1]
    if(id==NULL){               //if the argument  is null
        if(strcmp(argv[0],"fg")==0) fprintf(stderr,"fg command requires PID or %%jobid argument\n");	//print error message if no argument (fg or bg)
        else fprintf(stderr,"bg command requires PID or %%jobid argument\n");
        return;
    }else if(id[0] == '%'){               //if argument is a job id
        int jid = atoi(&id[1]);	
        p =  getjobjid(jobs,jid);	//set p = job with job id given in argument
        if(p==NULL){                                        //if no job with the given job id, print error
            fprintf(stderr,"%s: No such job\n",id);
            return;
        }
    }else if(isdigit(id[1])){             //if argument is a number (potential process id)
        int pid = atoi(id);		
        p = getjobpid(jobs,pid);		//set p = job with process id given in argument
        if(p==NULL){                                                //if no job with the given process id, print error
            fprintf(stderr,"(%d): No such process\n",pid);
            return;
        }
    }else{                                                              //if argument is not a number or invalid job id print error message
        if(strcmp(argv[0],"fg")==0) fprintf(stderr,"fg: argument must be a PID or %%jobid\n");	//error message if fg is called
        else fprintf(stderr,"bg: argument must be a PID or %%jobid\n");				//error message if bg is called
        return;
    }

    if(kill(-p->pid, SIGCONT) < 0) {                            //Send sigcont to the process group to continue
        fprintf(stderr,"Can't resume the process!\n");		//if not send error message
        return;
    }
    if(strcmp("fg", argv[0]) == 0) {                            //if the process is a foreground process 
        p->state = FG;						//set state to foreground
        waitfg(p->pid);						//wait for process to terminate
    }else{
        printf("[%d] (%d) %s", p->jid, p->pid, p->cmdline);	//if background, print background 
        p->state = BG;						//set state to background
    }
    return;
}

/* 
 * waitfg - Block until process pid is no longer the foreground process
 */
void waitfg(pid_t pid)
{
    struct job_t* tmp = getjobpid(jobs,pid);	//initialize tmp job_t*
    while (tmp->state == FG){ //check if fg is called, if not sleep
        sleep(1); // sleep
    }

    return;
}

/*****************
 * Signal handlers
 *****************/

/* 
 * sigchld_handler - The kernel sends a SIGCHLD to the shell whenever
 *     a child job terminates (becomes a zombie), or stops because it
 *     received a SIGSTOP or SIGTSTP signal. The handler reaps all
 *     available zombie children, but doesn't wait for any other
 *     currently running children to terminate.  
 */
void sigchld_handler(int sig)
{
    pid_t pid;		//initialize process id
    int status;		//initialize status
    while((pid= waitpid(WAIT_ANY,&status,WNOHANG|WUNTRACED)) > 0){
	if(pid < 1){		//if job is child and running break
		break;}
        else if(WIFSIGNALED(status)){	//if terminate signal is received, terminate job
            fprintf(stderr, "Job [%d] (%d) terminated by signal %d\n", pid2jid(pid),pid,WTERMSIG(status)); //print termination message
		deletejob(jobs,pid);	//delete job from job list
	}
        else if(WIFSTOPPED(status)){	//if stop signal is recieved, stop job
            fprintf(stderr, "Job [%d] (%d) stopped by signal %d\n", pid2jid(pid), pid, WSTOPSIG(status));	//print stopped message
            getjobpid(jobs,pid)->state = ST;}	//change state of job to stopped
	else if(WIFEXITED(status)){		//if exit signal is recieved
	    deletejob(jobs,pid);		//delete job
	}

   } 

    return;
}

/* 
 * sigint_handler - The kernel sends a SIGINT to the shell whenver the
 *    user types ctrl-c at the keyboard.  Catch it and send it along
 *    to the foreground job.  
 */
void sigint_handler(int sig)
{
    pid_t fgid = fgpid(jobs);	
    if(fgid){			//if fgid is valid and not 0
	kill(-fgid,SIGINT);	// send sigint to process group
	}
    return;
}

/*
 * sigtstp_handler - The kernel sends a SIGTSTP to the shell whenever
 *     the user types ctrl-z at the keyboard. Catch it and suspend the
 *     foreground job by sending it a SIGTSTP.  
 */
void sigtstp_handler(int sig) 
{
    int pid = fgpid(jobs);	//if fgpid is valid
   	if(pid!=0) kill(-pid,SIGTSTP);     //send sigtstp to the process group
 	return;
}

/*********************
 * End signal handlers
 *********************/

/***********************************************
 * Helper routines that manipulate the job list
 **********************************************/

/* clearjob - Clear the entries in a job struct */
void clearjob(struct job_t *job) {
    job->pid = 0;
    job->jid = 0;
    job->state = UNDEF;
    job->cmdline[0] = '\0';
}

/* initjobs - Initialize the job list */
void initjobs(struct job_t *jobs) {
    int i;

    for (i = 0; i < MAXJOBS; i++)
	clearjob(&jobs[i]);
}

/* maxjid - Returns largest allocated job ID */
int maxjid(struct job_t *jobs) 
{
    int i, max=0;

    for (i = 0; i < MAXJOBS; i++)
	if (jobs[i].jid > max)
	    max = jobs[i].jid;
    return max;
}

/* addjob - Add a job to the job list */
int addjob(struct job_t *jobs, pid_t pid, int state, char *cmdline) 
{
    int i;
    
    if (pid < 1)
	return 0;

    for (i = 0; i < MAXJOBS; i++) {
	if (jobs[i].pid == 0) {
	    jobs[i].pid = pid;
	    jobs[i].state = state;
	    jobs[i].jid = nextjid++;
	    if (nextjid > MAXJOBS)
		nextjid = 1;
	    strcpy(jobs[i].cmdline, cmdline);
  	    if(verbose){
	        printf("Added job [%d] %d %s\n", jobs[i].jid, jobs[i].pid, jobs[i].cmdline);
            }
            return 1;
	}
    }
    printf("Tried to create too many jobs\n");
    return 0;
}

/* deletejob - Delete a job whose PID=pid from the job list */
int deletejob(struct job_t *jobs, pid_t pid) 
{
    int i;

    if (pid < 1)
	return 0;

    for (i = 0; i < MAXJOBS; i++) {
	if (jobs[i].pid == pid) {
	    clearjob(&jobs[i]);
	    nextjid = maxjid(jobs)+1;
	    return 1;
	}
    }
    return 0;
}

/* fgpid - Return PID of current foreground job, 0 if no such job */
pid_t fgpid(struct job_t *jobs) {
    int i;

    for (i = 0; i < MAXJOBS; i++)
	if (jobs[i].state == FG)
	    return jobs[i].pid;
    return 0;
}

/* getjobpid  - Find a job (by PID) on the job list */
struct job_t *getjobpid(struct job_t *jobs, pid_t pid) {
    int i;

    if (pid < 1)
	return NULL;
    for (i = 0; i < MAXJOBS; i++)
	if (jobs[i].pid == pid)
	    return &jobs[i];
    return NULL;
}

/* getjobjid  - Find a job (by JID) on the job list */
struct job_t *getjobjid(struct job_t *jobs, int jid) 
{
    int i;

    if (jid < 1)
	return NULL;
    for (i = 0; i < MAXJOBS; i++)
	if (jobs[i].jid == jid)
	    return &jobs[i];
    return NULL;
}

/* pid2jid - Map process ID to job ID */
int pid2jid(pid_t pid) 
{
    int i;

    if (pid < 1)
	return 0;
    for (i = 0; i < MAXJOBS; i++)
	if (jobs[i].pid == pid) {
            return jobs[i].jid;
        }
    return 0;
}

/* listjobs - Print the job list */
void listjobs(struct job_t *jobs) 
{
    int i;
    
    for (i = 0; i < MAXJOBS; i++) {
	if (jobs[i].pid != 0) {
	    printf("[%d] (%d) ", jobs[i].jid, jobs[i].pid);
	    switch (jobs[i].state) {
		case BG: 
		    printf("Running ");
		    break;
		case FG: 
		    printf("Foreground ");
		    break;
		case ST: 
		    printf("Stopped ");
		    break;
	    default:
		    printf("listjobs: Internal error: job[%d].state=%d ", 
			   i, jobs[i].state);
	    }
	    printf("%s", jobs[i].cmdline);
	}
    }
}
/******************************
 * end job list helper routines
 ******************************/


/***********************
 * Other helper routines
 ***********************/

/*
 * usage - print a help message
 */
void usage(void) 
{
    printf("Usage: shell [-hvp]\n");
    printf("   -h   print this message\n");
    printf("   -v   print additional diagnostic information\n");
    printf("   -p   do not emit a command prompt\n");
    exit(1);
}

/*
 * unix_error - unix-style error routine
 */
void unix_error(char *msg)
{
    fprintf(stdout, "%s: %s\n", msg, strerror(errno));
    exit(1);
}

/*
 * app_error - application-style error routine
 */
void app_error(char *msg)
{
    fprintf(stdout, "%s\n", msg);
    exit(1);
}

/*
 * Signal - wrapper for the sigaction function
 */
handler_t *Signal(int signum, handler_t *handler) 
{
    struct sigaction action, old_action;

    action.sa_handler = handler;  
    sigemptyset(&action.sa_mask); /* block sigs of type being handled */
    action.sa_flags = SA_RESTART; /* restart syscalls if possible */

    if (sigaction(signum, &action, &old_action) < 0)
	unix_error("Signal error");
    return (old_action.sa_handler);
}

/*
 * sigquit_handler - The driver program can gracefully terminate the
 *    child shell by sending it a SIGQUIT signal.
 */
void sigquit_handler(int sig) 
{
    printf("Terminating after receipt of SIGQUIT signal\n");
    exit(1);
}






