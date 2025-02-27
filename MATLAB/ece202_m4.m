%Michael Gagliardi 12/7/2020 ECE 202 2020 MATlab Exercise 4
%Plotting multiple functions, truncated power serues, shifted sinosoid...
%Normalized Gaussian and Three Dampings for Parallel RLC
clf
clear
%%--------Part (a) Truncated Power Series------------

t = linspace(0,6,501); %%time in s for plotting
ft = 1 + t/2 - 1/3*t.^2; %truncated power series 
figure(1) %creating the first plot
plot(t,ft,"Linewidth",3) %%plotting

ax = gca; %%current axes
ax.FontSize = 12; %axes label font size

xlabel('time (s)', 'FontSize',15) %%labeling the x axis 
ylabel('f(t)', 'FontSize',15) %labeling the y axis

grid on %turning the grid on
ax.GridAlpha = 0.3; %setting grid line width
title('ECE 202 M4 (a) Truncated Power Series','fontsize',19) %title and font size

%----------Part (b) Shifted Sinusoid---------

x = linspace(-5,5,501); %creating x values for plotting
gx = 4*cos(3*(x - 2)); %shifted sinusoid function
figure(2) %assiging function to figure 2
plot(x,gx,'r',"Linewidth",3) %plotting function, linewidth is 3

bx = gca; %%current axes
bx.FontSize = 12; %setting axis label font size
ylim([-6 6])
xlabel('x (m)', 'FontSize',15) %x axis label 
ylabel('g(x)', 'FontSize',15) % y axis label

grid on %turing the grid on
bx.GridAlpha = 0.3; %setting grid width
title('ECE 202 M4 (b) Shifted Sinusoid','fontsize',19) %title and font size


%-----------Part (c) Normalized Gaussian--------

x = linspace(0,10,501); %creating x values for plotting
Px = 1/(2*sqrt(pi))*exp(-(x-5).^2/4); %normalized gaussian function
figure(3) %assigning to figure 3
plot(x,Px,"--","Linewidth",3) %plotting function, setting line width

cx = gca; %current axes
cx.FontSize = 14; %setting axis value font size


xlabel('x (m)', 'FontSize',18) %labelling x axis and setting font size
ylabel('Probability Density (1/m)', 'FontSize',18) %labelling y axis and... 
%setting font size

grid on %turning grid on
cx.GridAlpha = 0.3; %setting grid line width
title('ECE 202 M4 (c) Normalized Gaussian','fontsize',24) %title and font size

%--------Part (d) Three Dampings for Parallel RLC-----------

tms = linspace(0,40,501); %setting time in ms for plot
t = tms/1000; %converting ms to s
v1t = 16*exp(-800*t) - 4*exp(-200*t); %overdamped function
v2t = (12 - 6000*t).*exp(-500*t); %critically damped function
v3t = (12*cos(450*t) - 5*sin(450*t)).*exp(-120*t); %underdamped
figure(4) %assigning to figure 4
plot(tms,v1t,'r',tms,v2t,'g',tms,v3t,'b','linewidth',2)%plotting, assigning...
%colors and linewidth

cx = gca; %current axes
cx.FontSize = 12; %setting value fontsize

xlabel('time (ms)', 'FontSize',18) %labelling x axis and assigning font size
ylabel('Voltage (V)', 'FontSize',18)%labelling y axis 

grid on %turning grid on
cx.GridAlpha = 0.3; %setting grid width
title('ECE 202 M4 (d) Three Dampings for Parallel RLC','fontsize',19) %titling and setting..
%font size
legend({'overdamped', 'critically damped', 'underdamped'}, 'FontSize',15)
%creating legend and assigning labels

