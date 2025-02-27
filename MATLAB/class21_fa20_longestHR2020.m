% BL
% 10/9/20
% Class 21
% hitting a baseball, without drag (getting ready for Project 2)

clear; clf;

% longest home run of 2020: 495ft, Ronald Acuna, Jr., 9/25/20, BOS vs. ATL

% Citations:
% https://baseballsavant.mlb.com/leaderboard/statcast?type=batter&year=2020&position=&team=&min=q&sort=9&sortDir=desc
% https://www.mlb.com/video/ronald-acuna-homers-14-on-a-fly-ball-to-left-center-field


% ----- define given information -----

x0 = 0; y0 = 0;   % because we don't really care where it starts

v0mph = 114.8;   % exit velocity in mph, from baseballsavant.mlb.com
phi0deg = 18.6;   % launch angle in degrees, also from baseballsavant

                  % *** initial values of exit velocity and launch angle ***
                  % *** are different in Project 2 ***
                  
g = 10;   % gravitational constant in N/kg (1 N/kg = 1 m/s^2), i.e., ay = -g
          % positive constants are sometimes better, because
          % then we can "see" the minus signs in expressions


% ----- set up more variables -----

mph2mps = 5280 * 12 * 2.54 / 100 / 3600;   % mph to m/s conversion
deg2rad = pi()/180;   % degrees to radians conversion

v0 = v0mph * mph2mps;   % initial speed in m/s (no units in the variable name)
phi0 = phi0deg * deg2rad;   % initial angle in rad (no units in the variable name)

v0x = v0 * cos(phi0);   % x-component of initial velocity in m/s
v0y = v0 * sin(phi0);   % y-component of initial velocity in m/s


% ----- compute useful characteristics of the trajectory -----

% This will help interpret the output, make sure that it makes sense

tH = v0y/g   % time to reach max. height, in m
t_land = 2*tH   % time of flight, in s

H = tH * v0y/2   % maximum height, in m
R = v0x * t_land   % range, in m 
R_ft = R*3.3   % multiplying by 3.3 to estimate range in ft

               % *** you will need to compute a conversion factor ***
               % *** so that you can control its precision ***
               % *** also so that you can use it to convert from ft to m ***
               

% ----- set up a time array and compute x(t) and y(t) analytically -----

tmin = 0; tmax = t_land;   % stop when the ball lands
N = 2000;    % intervals
t = linspace(tmin, tmax, 1+N);   % time array, connects x(t) with y(t)

xt = x0 + v0x*t;   % x(t), ax = 0
yt = y0 + v0y*t - (1/2)*g*t.^2;    % y(t), ay = -g


% ----- add a numeric calculation of the trajectory -----

% *** This will be very different from what you are expected to do. ***

dt = (tmax-tmin)/N;

y = zeros(1, 1+N);   % initialize y(t)

y(1) = y0;
vy = v0y;   % vy(1) = v0y, but we DON'T need an array for vy

for n = 1:N   % stop at N
    
    ay = -g;   % treat ay as non-constant for now, so it stays inside FOR loop
    y(n+1) = y(n) + vy*dt + (1/2)*ay*dt^2;   % y'(t) = vy; y"(t) = ay
    vy = vy + ay*dt;    % redefine vy, i.e., vy(n+1) = vy(n) + ay*dt
    
    % *** This section will change A LOT in Project 2! ***
    
    % *** You will be treating Fnet as non-constant... ***
    % ***   ... so that it's MUCH easier to add drag in Phase 2... ***
    % ***   ... compute ax, ay...  compute vx, vy...  find x, y... ***
    
end


% ----- compare analytic to numeric -----

checkSumy = sum(abs(y-yt))  % We don't need to define check = y-yt.
                            % Use ABS to make each element positive
                            % before summing.  If the sum of 2001 
                            % positive numbers is 2.6e-10, then that's 
                            % a convincing check!

    


% ----- plot y vs. x -----

plot(xt, yt, xt, y, 'LineWidth', 2)
grid on

ax = gca; ax.FontSize = 16; ax.GridAlpha = 0.25;

xlabel('x (m)', 'FontSize', 18)   % *** use ft in Project 2 ***
ylabel('y (m)', 'FontSize', 18)

title({'ECE 202, Class 21: Trajectory of a baseball', ...
    'no drag, analytic vs. numeric'}, 'FontSize', 24)

legend({'analytic solution (behind numeric)', ...
    'numeric solution'}, 'FontSize', 18)

ylim([-5 20])  % a little space on the bottom, more on top for the legend


