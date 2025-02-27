% Michael Gagliardi 1/11/2021 ECE 202 M7
% Calculating and Plotting Current, Potential, and Power in an Inductor
% Circuit with respect to timne (switch closes at 0)
clear, clf

%-------givens-------------
R = 2;                                  % Resistance in ohms
L = 50;                                 % Inductance in mH
V0 = 10;                                 % Potential of the battery in V
T = L/R;                                % Tau (ms)
tmin = 0;                               %tmin in ms
tmax = 10*T;                            %tmax in ms
N = 500;                                %intervals
dt = (tmax-tmin)/N;                     %change in t in ms
t = linspace(tmin,tmax,N+1);            %time array in ms
iFinal = V0/R;                          %"final" current in A
%--------equations---------
i = iFinal*(1-exp(-t/T));           % Current in the circuit in Amps
v = V0*exp(-t/T);                 % Potential across the inductor in V
p = v.*i;                        % Power absorbed by the inductor in W
    
%------Plotting-------

subplot(3,1,1) %initializing subplot
plot(t,i, 'LineWidth', 2,'Color','r') %plotting first function
grid on                                % grid on and size adjustments
ax = gca; ax.FontSize = 15; ax.GridAlpha = 0.3;
ylabel('Current (A)');               %y label
text(160, .5, sprintf('$$ i(t) = %g \\cdot (1-e^{-t/%g}) $$', iFinal,T),...
    'Interpreter', 'latex', 'HorizontalAlignment', 'left',...
    'VerticalAlignment','bottom', 'FontSize', 18) %putting the equation on plot

subplot(3,1,2) %creating subplot 2
plot(t,v,'LineWidth', 2); %plotting second function
grid on                     %creating grid and adjusting
ax = gca; ax.FontSize = 15; ax.GridAlpha = 0.3;
ylabel('Voltage (V)'); %labeling y axis
text(175, 7, sprintf('$$ v(t) = %g \\cdot e^{-t/%g}  $$',V0,T),'Interpreter',... 
'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment','bottom',...
'FontSize', 18) %putting the equation on the plot

subplot(3,1,3) %creating subplot 3
plot(t,p,'LineWidth', 2,'Color','g'); %plotting the third function
grid on                             % creating the grid and adjusting
ax = gca; ax.FontSize = 15; ax.GridAlpha = 0.3;
ylabel('Power Absorbed (W)'); %y axis label
text(175, 12, '$$ p(t) = v(t) \cdot i(t) $$','Interpreter', 'latex', ...
'HorizontalAlignment', 'left', 'VerticalAlignment','bottom','FontSize', 18)
xlabel('Time (ms)') %% x axis label
vstr = num2str(V0);
rstr = num2str(R);
Lstr = num2str(L);
sgtitle({'ECE 202 M7: Current, voltage, and power absorbed', ...
    ['for a charging inductor (V_{0}=',vstr,'V R=',rstr,'\Omega L=',Lstr,'mH)']}, ...
    'FontSize', 24, 'FontWeight', 'b') %titling the subplots

%-------Check-------


wFinal = (L*(V0/R)^2)/2  % Final energy stored in the inductance in mJ
wAbs = sum(p)*dt %total energy absorbed in mJ
diff = abs(wFinal - wAbs) %calculating difference between final and total energy
pctError = diff/wFinal*100 %calculating percent error
