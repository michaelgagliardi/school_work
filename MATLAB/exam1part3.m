 % Michael Gagliardi 
% 9.18.2020
% ECE 202 Fall 2020, Exam 1 Part 3
%Computing and graphing a function
%clear
%clc

% -------given --------

% original function: f(t) = a*cos(w*t) + b*sin(w*t)
% rewritten as f(t) = K*cos(w*t + pa) pa = phase angle
% K^2 = a^2 + b^2

tms = linspace(0,80,501); %intialize  time array in ms
t = tms/1000; % time in seconds for computations

a = input("Enter value a: "); %inputting value for a
b = input("Enter value b: "); %inputting value for b
w = 100; % angular velocity in rad/s
wt = w*t; %establishing variable used multiple times

%-------computations ---------

K = sqrt(a^2 + b^2); % calculating value of amplitude

if a > 0 
    pa = atan(-b/a) %phase angle if a > 0
else
    pa = pi + atan(-b/a) %phase angle if a < 0
end

%if pa > pi %if phase angle is greater than pi, subtract 2pi until it isnt
    %n = floor(pa/(2*pi));
    %pa = pa - n*2*pi;
%end
%if pa < -pi %if phase angle is less than -pi, add 2pi until it isnt
    %n = floor(pa/(2*pi));
    %pa = pa + n*2*pi;
%end

%if b || a == 0 
%    disp('a and b cannot be 0')
%    return
%end

f1 = a*cos(wt); %defining function 1
f2 = b*sin(wt); %defining function 2
ft = K*cos(wt+pa); %defining the main function
check = f1+f2-ft; %defining checking function

%--------plotting----------

plot(tms, check, tms, ft, tms, f1, '--', tms, f2, '--', 'LineWidth', 2) % creating the figure, f1&f2 are dotted
axis([-inf inf -K*1.2 K*2]); % setting the y limit
ax = gca;
ax.FontSize = 12; % increasing font size

grid on %turning grid on
ax.GridAlpha = 0.3; %making grid thicker/easier to see
xlabel('time (ms)', 'FontSize',15) %labeling the x axis
legend('check','ft','f1','f2') %creating the legend




