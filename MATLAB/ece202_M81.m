%Michael Gagliardi
%ECE 202 Exercise M8 1/6/21
%Computing coefficents of partial fraction expansion
% rx = (6 + 5*x + 4*x^2)/(x-1)(x-2)(x-3) original function
A = [6 3 2;... % initializing the A matrix based off the equation provided 
    -5 -4 -3;...
    1 1 1];

B = [6; 5; 4]; %the B matrix based off the equation provided and hand calc

c = A^(-1)*B %solving for three coeffiecents

N = input('Number of points? '); %input number of points
x = linspace(-4,4,N) %initializing x array 

Nx = B(1) + B(2)*x + B(3)*x.^2; %computing numerator

d1 = x-1; %computing denominators
d2 = x-2;
d3 = x-3;

rx = Nx./(d1.*d2.*d3); %computing the function for each x
r1 = c(1)./d1;                       %computing r1 for each value of x 
r2 = c(2)./d2;                       %computing r2 for each value of x
r3 = c(3)./d3;                       %computing r3 for each value of x

checkR = sum(abs(rx-(r1+r2+r3))) %checking that each rx = r1 + r2 + r3

%this check does not always work because of the 'd' values. If x = 1,2,or
%3, than r1, r2, or r3 would be undefined since one of the d values would =
%0. As long as the number of points are such that x will not equal 1, 2, or
%3, then the check will work. When N = 5, the corresponding x values are -4,
%-2,0,2,4. Since there is an instance where x = 2, this would result in an
% undefined d2, rendering the check ineffective. For N = 6, the x values
% are -4, -2.4, -0.8, 0.8, 2.4, and 4. None of the x values are 1, 2, or 3,
% so the check will work and none of the d values will be undefined.