### ECE 241 Homework 1 Michael Gagliardi due 09/01/2020

## 1)


class Hw1Q1: ###defining class

    @staticmethod
    def timeConvert(input_seconds): ###defining function within class
        k=input_seconds
        if input_seconds>=86400: ##converting seconds to closest number of whole days, assigning remainder to variable
            days=input_seconds//86400
            x=input_seconds%86400
        else:
            days=0
            x=input_seconds
        if input_seconds>=3600:   ##converting the remainder from days to hours
            hours=x//3600
            y=x%3600
        else:
            hours=0
            y=input_seconds
        if input_seconds>=60:   ##converting remainder from hours to minutes
            minutes=y//60
            z=y%60
        else:
            minutes=0
            z=input_seconds
        seconds=z  ##remaining seconds
        if days==0:      ###following code ignores if any time increment is 0 and also converting integers to string
            Days= ""
        elif k==86400:
            Days=str(days)+" day"
        elif days==1:
            Days=str(days)+" day, "
        elif k % 86400 ==0 and k != 86400:
            Days=str(days)+" days"
        else:
            Days= str(days)+" days, "
        if hours==0:
            Hours=""
        elif k == 3600:
            Hours=str(hours)+" hour"
        elif hours==1:
            Hours=str(hours)+" hour, "
        elif k % 3600==0 and k!=3600:
            Hours= str(hours)+ " hours"
        else:
            Hours= str(hours)+" hours, "
        if minutes==0:
            Minutes=""
        elif k==60:
            Minutes=str(minutes)+ " minute"
        elif minutes==1:
            Minutes=str(minutes)+ " minute, "
        elif k % 60 ==0 and k!=60:
            Minutes=str(minutes)+ " minutes"
        else:
            Minutes= str(minutes)+ " minutes, "
        if seconds==0:
            Seconds=""
        elif seconds==1:
            Seconds=str(seconds)+" second "
        else:
            Seconds= str(seconds) + " seconds"

        return Days+Hours+Minutes+Seconds  ##output
if __name__ == "__main__":
    print(Hw1Q1.timeConvert(100000))

