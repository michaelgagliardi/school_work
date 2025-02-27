%Michael Gagliardi 1/6/20
%ECE 202 Project 1 Phase 2
%Rewriting a sinusoidal function of time as a truncated power series ...
%using the Taylor series expansion, cleaning up output
clear,clf

format shortG %clean formatting
n = [0:2:10]; %n array of even numbers and 0 since all odd numbers are 0
a = (-1).^(n/2).*(12*40.^n./factorial(n)); %an array for coefficients of non zero terms
tms=linspace(0,200,501); %creating time array in miliseconds
t=tms/1000; %time in seconds for calculations
ft=12*cos(40*t); %original function for reference

Coef_table = table(n.',a.','VariableNames',{'n','Coefficent'}) %creating table

f1 = a(1)*t.^n(1); %the first non-zero term
f2 = f1 + a(2)*t.^n(2); %the sum of first 2 non-zero terms
f3 = f2 + a(3)*t.^n(3); %the sum of first 3 non-zero terms
f4 = f3 + a(4)*t.^n(4); %the sum of first 4 non-zero terms
f5 = f4 + a(5)*t.^n(5); %the sum of first 5 non-zero terms
f6 = f5 + a(6)*t.^n(6); %the sum of first 6 non-zero terms

plot([0,200],[0,0],'k','lineWidth',1); %plotting x axis
hold on

p1=plot(tms,f1,tms,f2,tms,f3,tms,f4,tms,f5,'lineWidth',1.5); %plotting first 5 graphs
p2=plot(tms,f6,'black','lineWidth',3); %plotting 6th graph
hold off

ax = gca; ax.FontSize = 15; %setting font sizes
grid on %turning grid on
ax.GridAlpha = 0.3;

xlabel('time (ms)', 'FontSize',18) %labeling the x axis
ylabel('f(t)', 'FontSize',18) %labeling the y axis
title({'ECE 202 Project 1 Phase 2: f(t)=12cos(40t) as a',...
    'Truncated Power Series, Sum up to Six Nonzero Terms'},'FontSize',21)%title
ylim([-15 15]) %setting y limits

legendText = "up to n= " + n; %creating legendText variable for legend
legend([p1; p2],legendText,'Location','northeastoutside',...
    'FontSize',18) %creating legend
