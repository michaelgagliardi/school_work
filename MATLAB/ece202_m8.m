%%Michael Gagliardi
%ECE202 M8 Computing Coeffiecents for Partial Fraction Expansion

N = input("Enter number of points: ")
x = linspace(-4,4,N);
d1x = x-1;
d2x = x-2;
d3x = x-3;
b = [4;5;6]
A = [1 1 1;-5 -4 -3;6 3 2]
Nx = 
c = linsolve(A,b)
N1 = c(1).*d2x.*d3x - b(1)
N2 = c(2).*d1x.*d3x - b(2)
N3 = c(3).*d1x.*d3x - b(3)