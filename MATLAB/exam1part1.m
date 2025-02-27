
% 9/18/20
% ECE 202, Exam 1
%Predicting the final velocities of two carts that collide elastically
  
% ----- givens -----

m1 = 100

m2 = 200

M = m1+m2   %(total mass of m1 and m2)

v1i = 40

v2i = 20

%----- calculation -----

 %answer to part (a)...

v1f = 1/M*((m1-m2)*v1i + 2*m2*v2i)

%answer to part (b)...

cart2v_final = ((2*m1)*v1i)/(M) + ((m2 - m1)*20)/(M)



% ----- check momentum conservation -----

p0 = (m1*v1i) + (m2*v2i)

pf = m1*v1f + m2*cart2v_final   %(p0 should be equal to pf)