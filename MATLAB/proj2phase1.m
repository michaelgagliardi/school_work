%Michael Gagliardi
%1/6/21
%Project 2: Hitting a home run with air resistance, determining the net...
%force, time of flight, range, and maximum height
%
%Phase 1: Comparing the analytic solutions to the numeric,
%without drag determining the trajectory of a baseball
%
clear; clf;

% ----- define given information -----

x0 = 0; y0 = 0; 
v0mph = 112;   % exit velocity in mph
phi0deg = 32;   % launch angle in degrees             
g = 9.8; %gravitational constant (or acceleration to do gravity in m/s^2)
m = 0.145; %mass of baseball in kg

% ----- more variables -----

mph2mps = 5280 * 12 * 2.54 / 100 / 3600;   % mph to m/s conversion
deg2rad = pi()/180;   % degrees to radians conversion
m2ft = 3.281; %meters to feet conversion
v0 = v0mph * mph2mps;   % initial speed in m/s
phi0 = phi0deg * deg2rad;   % initial angle in rad 
v0x = v0 * cos(phi0);   % x-component of initial velocity in m/s
v0y = v0 * sin(phi0);   % y-component of initial velocity in m/s

% ----- useful characteristics of the trajectory -----

tH = v0y/g;   % time to reach max. height, in m
t_land = 2*tH;   % time of flight, in s
H = tH * v0y/2;   % maximum height, in m
R = v0x * t_land;   % range, in m 

% ----- set up a time array and compute x(t) and y(t) analytically -----

tmin = 0; tmax = t_land;   % stop when the ball lands
N = 2000;    % intervals
t = linspace(tmin, tmax, 1+N);   % time array, connects x(t) with y(t)
xt = x0 + v0x*t;   % x(t), ax = 0 in m
yt = y0 + v0y*t - (1/2)*g*t.^2;  % y(t), ay = -g in m
xt = xt*m2ft; %x(t) in ft
yt = yt*m2ft; %x(t) in ft

% ----- numeric calculation of the trajectory -----

dt = (tmax-tmin)/N;
y = zeros(1, 1+N);   %initialize y(t)
x = zeros(1, 1+N);   %initialize x(t)
y(1) = y0;
vy = v0y;   
vx = v0x;
for n = 1:N   % stop at N
    Fx = 0; %x component of Fnet
    Fy = m*-g; %y component of Fnet
    ay = Fy/m; %acceleration in y direction
    ax = Fx/m; %acceleration in x direction
    y(n+1) = y(n) + vy*dt + (1/2)*ay*dt^2;   
    vy = vy + ay*dt; % redefining vy
    x(n+1) = x(n) + vx*dt + (1/2)*ax*dt^2; %computing x(t)
    vx = vx + ax*dt; %redifining vx
end
y = y*m2ft; %converting m to feet
x = x*m2ft; %converting m to feet

%--------checking numeric vs analytical-------
checkXsum = sum(abs(x-xt)) %%should be 0 if analytical and numerical are same
checkYsum = sum(abs(y-yt)) %%should be 0 if analytical and numerical are same

% ----- plot -----
plot(xt, yt, x, y, 'LineWidth', 2)
grid on
ax = gca; ax.FontSize = 16; ax.GridAlpha = 0.25;
xlabel('x (ft)', 'FontSize', 18)  
ylabel('y (ft)', 'FontSize', 18)
title({'ECE 202 Project 2 Phase 1: Trajectory of a baseball', ...
    'no drag, analytic vs. numeric'}, 'FontSize', 24)
legend({'analytic solution (behind numeric)', ...
    'numeric solution'}, 'Location','northeast','FontSize', 18)
ylim([y0-5,H*m2ft+20])

