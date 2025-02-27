%Michael Gagliardi
%1/14/21
%Project 2: Hitting a home run with air resistance, determining the net...
%force, time of flight, range, and maximum height
%Phase 2: Comparing the solutions without drag to the solution
%with drag in determining the trajectory of a baseball
%
clear; clf;

% ----- define given information -----

x0 = 0; y0 = 0; 
v0mph = 112;   % exit velocity in mph
phi0deg = 32;   % launch angle in degrees             
g = 10; %gravitational constant (or acceleration to do gravity in m/s^2)
m = 0.145; %mass of baseball in kg
r = 1.43; %radius of baseball in inches 
C = input('Enter drag constant: '); %user inputted drag constant
A = pi()*(r*0.0254)^2; %cross sectional area of baseball in m^2
p = 1.225; %air density in kg/m^3 at around 65 degrees F
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
y(1) = y0; %the first y position is the baseball's initial y position
x(1) = x0; %the first x position is the baseball's initial x position
vy = v0y;  %y velocity is y component of baseball's initial speed
vx = v0x;  %x velocity is x component of baseball's initial speed
drag = 0.5*C*A*p;%defining a constant to make drag force calculations effiecent

for n = 1:N   % stop at N
    v = sqrt(vx^2+vy^2); %redefining v
    Fx = -drag*vx*v; %x component of Fnet
    Fy = -drag*vy*v - g*m; %y component of Fnet
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
grid minor
ax = gca; ax.FontSize = 16; ax.GridAlpha = 0.4; ax.MinorGridAlpha = 0.5;
xlabel('x (ft)', 'FontSize', 18)  
ylabel('y (ft)', 'FontSize', 18)
str = {sprintf('with drag constant: %g' , C)};
str = ['without drag' str];
title({'ECE 202 Project 2 Phase 2: Trajectory of a baseball', ...
    'with and without drag'}, 'FontSize', 24);
legend(str{:},'Location','northeast','FontSize', 18);
ylim([y0-5,H*m2ft+20])

