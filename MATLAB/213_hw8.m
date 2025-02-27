
Nn = length(n);

Nt = 10001;
t = linspace(-4,4,Nt);
n = [1:10];


xn = (1 - exp(-1i*n*pi)./(1i*n*pi));


x1 = zeros(Nt,1);
y1 = zeros(Nt,1);
for i = 1:length(n);
    x = x + xn(i)*exp(1i*n
end
x2 = zeros(Nt,1);
y2 = zeros(Nt,1);
