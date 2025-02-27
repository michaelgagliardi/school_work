% Michael Gagliardi 12/7/2020 ECE 202 2020 MATlab Exercise 2
% Equations from: Carl R. (Rod) Nave; Department of Physics and Astronomy; Georgia...
% State University
% http://hyperphysics.phy-astr.gsu.edu/hbase/colsta.html
% Two carts of the same mass and opposite velocities are travelling...
% along the same line. They collide elastically, which brings cart 1 to a...
% complete stop.

% ------- given --------

m2 = 150; % mass of cart 2 in grams
v1i = 30; % initial velocity of cart 1 in cm/s
v2i = -30; % initial velocity of cart 2 in cm/s
v1f = 0; % cart 1 comes to complete stop, so velocity is zero

%-----calculations -------

m1 = (-2*v2i+v1i+v1f)*m2/(v1i-v1f) % solve for m1, unsupressed output
M = m1+m2; % define sum of both carts' masses
v2f = 1/M*(2*m1*v1i - (m1-m2)*v2i) %calculating final velocity of cart 2

%---checking answer-----

checkP = (m1*v1i + m2*v2i) - (m1*v1f + m2*v2f) % checking via conservation of momentum...
%should be zero

checkE = (0.5*m1*v1i^2 + 0.5*m2*v2i^2) - (0.5*m1*v1f^2 + 0.5*m2*v2f^2) % checking... 
% via conservation of energy, should be zero

v1f = 1/M*((m1-m2)*v1i + 2*m2*v2i) % checking by solving for final velocity of... 
% cart 1, should be 0 to match design criterion
%Design is successful.

