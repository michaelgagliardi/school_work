clear
m = [10 20]
v0 = [12 -8]
    
p0 = m(1)*v0(1) + m(2)*v0(2)  %total initial momentum in the system
    
E0 = sum((1/2)*m.*v0.^2)   %total initial energy in the system
    
Vf = p0./(m(1)+m(2))  %final velocity of m1 and m2, after they stick together

vf = p0/sum(m)  

p1 = sum(m.*v0)