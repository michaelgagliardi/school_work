%Michael Gagliardi
%8/28/2020
%ECE 202 Fall 2020 Class 3
%Design problem: find the min.coef. of static friction

clear %mostly avoids typos 

%-------given information--------%

d_stop = 120; % min.stopping distance, in m
v0kph = 100; % initial velocity in km/h
g = 10; % gravity

% convert v0 to m/s

v0 = v0kph*1000/3600; %km/h to m/s, v0


% ------- compute the min. coef. of static friction -----%

us = v0^2 / (2*g*d_stop) 


% ------- check ------ class 2 script ----

m=950; %mass of car in kg
vf=0; % final velocity, m/s 

% calculations

Fmax = -us*m*g; %answer to (a), max net force/frictional force/Fx

amax = Fmax/m; %answer to (b), max. acceleration, in m/s

tmin = (vf-v0)/amax; %min time to stop, in seconds

dmin = v0*tmin + (1/2)*amax*tmin^2; %min distance to come to a complete stop in m

checkd_stop = dmin - d_stop % should be zero
