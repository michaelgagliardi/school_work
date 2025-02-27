%Michael Gagliardi 12/7/20
%ECE 201 Project 1 Phase 1
%Rewriting a ft=12*cos(40*t) as a truncated power series using the Taylor ...
%series expansion. Plotting truncated power series for f(t) from t = 0 to
%t = 0.2s starting with first non-zero term up to six non-zero terms,
%getting something together quickly
clear,clf

format shortG %clean formatting
n = [0:2:10]; %n array of even numbers and 0 since all odd numbers are 0
a = (-1).^(n/2).*(12*40.^n./factorial(n)) %an array for coefficients of non zero terms
t=linspace(0,0.2,400); %creating time array in seconds
ft=12*cos(40*t); %original function for reference
f1 = a(1).*t.^n(1); %the first non-zero term
f2 = f1 + a(2)*t.^n(2); %the sum of first 2 non-zero terms
f3 = f2 + a(3)*t.^n(3); %the sum of first 3 non-zero terms
f4 = f3 + a(4)*t.^n(4); %the sum of first 4 non-zero terms
f5 = f4 + a(5)*t.^n(5); %the sum of first 5 non-zero terms
f6 = f5 + a(6)*t.^n(6); %the sum of first 6 non-zero terms

plot(t,f1,t,f2,t,f3,t,f4,t,f5,t,f6,'lineWidth',3)
ax = gca;
ax.FontSize = 12;
grid on %turning grid on
ax.GridAlpha = 0.3;
xlabel('time (s)', 'FontSize',15) %labeling the x axis
ylabel('f(t)', 'FontSize',15) %labeling the y axis
sgtitle({'ECE 202 Project 1 Phase 1: f(t)=12cos(40t) as a',...
    'Truncated Power Series, up to Six Nonzero Terms'})%title
ylim([-15 15])
