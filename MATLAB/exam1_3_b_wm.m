%Michael Gagliardi
%12/21/20
%ECE 202 Winter 2020, Exam 1 Part 3.b
%Plotting a damped sinusoid with its upper and lower envelope functions
clear
clf

%-----given------

%original function: f(t) = Ae^(-kt)cos(wt)

A = input('Enter value for A:'); %user inputs value for A assumed positive
k = input('Enter value for k:'); %user inputs value for k in Hz
w = input('Enter value for w:'); %user inputs value for w in rad/s
x = 3/k; %since 3/k will be used often, setting value to x
t = linspace(0,x,501); %initializing time array in s to compute
e = exp(-k*t); %value will be used multiple times, assigning to variable
tplot = t; %initialzing the time array to plot

%-------time scale dependecies-------
label = 'time in s';
if 0.001<x && x<1 %if 3/k is less than 1 s but greater than 1 ms
    tplot = t*1000; %plot in ms
    label = 'time in ms';
    x = x*1000;
end
if x<0.001 %if 3/k is less than 1 ms
    tplot = t*1^6; %plot in us
    label = 'time in us';
    x = x*1^6;
end

%------plotting--------
ue = A*e; %upper envelope function
le = -A*e; %lower envelope function
ft = A*e.*cos(w*t); %damped sinusoid

plot(tplot, ft, tplot, ue, '--', tplot, le, '--', 'LineWidth', 3) % creating the figure, f1&f2 are dotted
axis([0 x -inf inf]); % setting the x limit
ax = gca;
ax.FontSize = 12; % increasing font size

grid on %turning grid on
ax.GridAlpha = 0.3; %making grid thicker/easier to see
xlabel(sprintf(label),'FontSize',15)%labeling the x axis
ylabel('y', 'FontSize',15)%y label
legend('ft','Upper Envelope','Lower Envelope') %creating the legend
title({'ECE 202 Exam 1 Part 3b: Plotting Damped Sinusoid','ft=Ae(-kt)cos(wt)'}...
    ,'FontSize',24) %plotting title

