% Michael Gagliardi 12/7/2020 ECE 202 2020 MATlab Exercise 1
% Equations from: Carl R. (Rod) Nave; Department of Physics and Astronomy; Georgia... 
% State University
% http://hyperphysics.phy-astr.gsu.edu/hbase/colsta.html
% Two carts of different masses and different velocities are travelling
% along the same line. They collide elastically.clc

%-----given information----
m1 = 250; %mass of cart 1 in grams
m2 = 150; %mass of cart 2 in grams
M = m1+m2; %mass of cart 1 and cart 2 total in grams
v1i = 40; %initial velocity of cart 1 in cm/s
v2i = -30; %initial velocity of cart 2 in cm/s

%-----calculations-----

v1f = 1/M*((m1-m2)*v1i + 2*m2*v2i) %calculating final velocity of cart 1
v2f = 1/M*(2*m1*v1i - (m1-m2)*v2i) %calculating final velocity of cart 2

%---checking answer-----

checkP = (m1*v1i + m2*v2i) - (m1*v1f + m2*v2f) %%checking via momentum ...
%should be zero
checkE = (0.5*m1*v1i^2 + 0.5*m2*v2i^2) - (0.5*m1*v1f^2 + 0.5*m2*v2f^2) %%checking...
%%energy should be zero
