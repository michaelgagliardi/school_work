%Michael Gagliardi
%12/21/20
%ECE 202 Winter 2020, Exam 1 Part 3.a
%Testing and proving the product of powers property
%e^(a+b) = e^a*e^b
clear

%-------calculating--------

%original equation: e^2*e^3x*e^(-x^2/4) = e^(2+3x-x^2/4)
x = linspace(-5,5,11); %creating array of integers from -5 to 5
n1 = exp(2+3*x - x.^2/4); %calculating the first expresion, e^(2+3x-x^2/4)
n2 = exp(2)*exp(3*x).*exp(-x.^2/4); %calculating second expression...
%e^2*e^3x*e^(-x^2/4)
checkn = sum(n1-n2) %checking by subtracting the values of the first expression...
%by the values of the second expression, should be zero
