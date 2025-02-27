%Michael Gagliardi 1/15/21
%ECE 201 Project 1 Phase 5
%Rewriting a sinusoidal function of time as a truncated power series ...
%using the Taylor series expansion, add for loop
clear,clf

format shortG %clean formatting
%ft=A*cos(wt) general form of equation
%------------Parameters---------------
A = 12; %Amplitude
w = 40; %Angular frequency rad/s
terms = input('Enter number of nonzero terms to sum: '); %Number of nonzero terms
tmax = input('Enter max time to graph in ms: '); %Max time in ms
tmin = input('Enter min time to graph in ms: '); %min time in ms
N = input('Enter number of intervals to graph: '); %number of intervals

%-----------Arrays and tables---------------------
n = [0:2:terms*2-2]; %n array of even numbers and 0 since all odd numbers are 0
a = (-1).^(n/2).*(A*w.^n./factorial(n)); %an array for coefficients of nonzero terms
tms = linspace(tmin,tmax,N+1); %creating time array in miliseconds
t = tms/1000; %time array in seconds for calculations
ft = A*cos(w*t); %original function for reference

Coef_table = table(n.',a.','VariableNames',{'n','Coefficent'}) %creating table 
sz = size(t);
f = zeros(sz);
p=[];

for k = 1:terms
    f = f + a(k)*t.^n(k); %adding each nonzero term to the previous
    if k == terms %plotting last function with a thicker line
        p(k) = plot(tms,f,'black','linewidth',3);
    else
        p(k) = plot(tms,f,'linewidth',1.5);
    end
    hold on
end
f1 = a(1)*t.^n(1); %the first non-zero term
f2 = f1 + a(2)*t.^n(2); %the sum of first 2 non-zero terms
f3 = f2 + a(3)*t.^n(3); %the sum of first 3 non-zero terms
f4 = f3 + a(4)*t.^n(4); %the sum of first 4 non-zero terms
f5 = f4 + a(5)*t.^n(5); %the sum of first 5 non-zero terms
f6 = f5 + a(6)*t.^n(6); %the sum of first 6 non-zero terms

if terms == 6
    checkf=sum(abs(f6-f)) %checking that last functions match up, should be 0
end

avgdev = sum(abs(ft-f)/N) %calculating average deviation

plot([tmin,tmax],[0,0],'k','lineWidth',1); %plotting x axis
hold off

ax = gca; ax.FontSize = 15; %setting font sizes
grid on %turning grid on
ax.GridAlpha = 0.3;

xlabel('time (ms)', 'FontSize',18) %labeling the x axis
ylabel('f(t)', 'FontSize',18) %labeling the y axis
xlim([tmin tmax]) %setting x limits
ylim([-A-2/3*A, A+1/4*A]) %setting y limits 

titleText = sprintf('ECE 202 Project 1 Phase 5: f(t)=%gcos(%gt) as a',A,w);
titleText2 = sprintf('Truncated Power Series, Sum up to %g Nonzero Terms',terms);
titleText3 = sprintf('Average Deviation: %g',avgdev);
title({titleText,titleText2,titleText3},'FontSize',21)%title

legendText = "up to n= " + n; %creating legendText variable for legend
legend(p,legendText,'Location','northeastoutside',...
    'FontSize',18) %creating legend