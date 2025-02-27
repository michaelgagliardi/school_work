% Michael Gagliardi 12/7/2020 ECE 202 2020 MATlab Exercise 5
% Equations from: Carl R. (Rod) Nave; Department of Physics and Astronomy; Georgia... 
% State University
% http://hyperphysics.phy-astr.gsu.edu/hbase/trid.html
% Graphing a sinosoid and two sinusoids whose sum is equivalent
%Formula for turning the product of two sinusoids into the sum of two...
%sinusoids: cos(a)cos(b)=0.5(cos(a+b)+cos(a-b)) showing this to be true
clf,clear
%----original function-------

tms = linspace(0,200,501); %intialize  time array in ms
t = tms/1000; % time in seconds for computations
K = 12; %defining coefficent K, the coefficent '12'
a = 60*t - 1.8; %defining a since it is used multiple times
b = 100*t + 1.2; %defining b since it is used multiple times
ft=K*cos(a).*cos(b); %original function

%-----2 sinusoids that add up to original-----

f1t = 0.5*K*cos(a+b); %%function 1
f2t = 0.5*K*cos(a-b); %%function 2
check1 = f1t+f2t-ft; %%checking that the sum of both functions add to original...
%should output a straight line at 0

check2 = sum(abs(check1)) %%since the sum of f1t and f2t should be equivalent
%%to ft, adding the sum of f1t and f2t and subtracting ft should result in
%%an array of really small numbers. If some values of f1t or f2t are
%%negative but equal in magnitude to other values, summing this would result in a
%%sum of 0, and would invalidate our check (e.g. 12 + -12 is 0, but neither
%%are really small numbers which indicates our check is wrong). By using
%%the abs function, this insures that the sum of f1t and f2t is extremely
%%close to the values (not just magnitude) of the values in ft.

%------plotting-------

plot(tms, ft,'g', tms, f1t,'r', tms, f2t,'b', tms, check1,'black','LineWidth', 2)

ax = gca;
ax.FontSize = 12; % increasing font size

grid on %turning grid on
ax.GridAlpha = 0.3; %making grid thicker/easier to see
xlabel('time (ms)', 'FontSize',15) %labeling the x axis
ylabel('f(t)', 'FontSize',15) %labeling the y axis
t = title({'ECE 202 M5: Proof the Product of 2 Sinusoids Can', 'Be Written as the Sum of 2 Sinusoids'},'FontSize',21);
t.FontWeight = 'bold';
legend('f(t)=Product of 2 Sinusoids','f1=Sinusoid 1','f2=Sinusoid 2','check = ft - (f1+f2), should be 0',...
    'FontSize',15) %creating the legend

