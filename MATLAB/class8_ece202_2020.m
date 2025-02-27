% Michael Gagliardi
% 9.9.2020
% ECE 202 Class 8


% plot multiple graphs on one figure (one set of axes), with legend

%sinusoidal voltage source vs = 10 cos(50t) 50 rad/s
% R in series with vs, ZR = 3 ohm;
% L in series with vs, ZL = j4ohm

% I = 10/(3+j4) = 10/5 <53.1 deg
% vR = 6<- 53.1 deg --> vR(t) = 6 cos(50t-53.1deg)
% vL = 8<36.9deg --> vL(t) = 8 cos(50t+36.9deg)

% plot in ms, 0 to 200 ms

tms = linspace(0,200,501); % time in miliseconds, for plotting, 
t = tms/1000; % time in s, for computing voltage

vs = 10*cos(50*t); % array of vs value, voltage across the sourcfe
vR = 6*cos(50*t - 53.1*pi/180); % resistor voltage
vL = 8*cos(50*t + 36.9*pi/180); 

plot(tms, vs, tms, vR, '--', tms, vL, ':', 'LineWidth', 2)

ax = gca;
ax.FontSize = 12;

legend({'voltage source vs', 'resistor vR', 'inductor vL'}, 'FontSize',15)

xlabel('time (ms)', 'FontSize',15)
ylabel('voltage (v)', 'FontSize',15)

grid on
ax.GridAlpha = 0.3;

title('ECE 202 Class 8 Voltages across vs, R, and L in series, vs = vR + vL', 'FontSize', 19)

axis([-inf inf -12 16])






