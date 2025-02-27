% Michael Gagliardi
% 9.7.2020
% ECE 202 Fall 2020, class 7
% three different functions, some with dots

clear
clf % clears figures

t = linspace(0,10,401);
f = 8*sin(2*t) - 6*cos(2*t); % no dots are needed for + or - arrays

plot(t,f)
grid on

figure

t2 = linspace(-10, 10, 1001);
g = 10 * t2 .* cos(4*t2);  %'weird' sinusoid, one dot

plot(t2,g)

grid on

figure

h = 10*exp(-t/4) .* cos(5*t); % one dot (damped sinusoid)

plot(t,h)

grid on

