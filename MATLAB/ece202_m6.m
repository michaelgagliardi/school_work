% Michael Gagliardi 10/27/2020 ECE 202 2020 MATlab Exercise 5
% Equations from: Carl R. (Rod) Nave; Department of Physics and Astronomy; Georgia... 
% State University
% http://hyperphysics.phy-astr.gsu.edu/hbase/colsta.html
% Three carts of different masses and different velocities are travelling
% along the same line. They collide elastically.
clear

%------given information -------
global m
m = input('Enter three masses surrounded by brackets');
v = input('Enter three velocities surrounded by brackets');
totalP = sum(m.*v); % total momentum of the system
totalE = sum(0.5*m.*v.^2); % total energy of the system
i = 0;
%--------first collsion -----------
vf = [0 0 0]; %initializing array for first collision
vf(1) = v(1); %cart 1 is not in first collision, velocity stays same
vf(2) = V(m(2), m(3), v(2), v(3)); % final velocity for cart 2
vf(3) = vf2(m(2), m(3), v(2), v(3)); %final velocity for cart 3

checkP = totalP-sum(m.*vf);
checkE = totalE-sum(0.5*m.*vf.^2);
i = i+1;
disp("Collision: " + i)
vf
checkP
checkE

%----------- subsequent collisons ----------
 
while vf(1) > vf(2) || vf(2) > vf(3)
    if vf(1) > vf(2) %if cart 1 and 2 are gonna crash
        x=1
        y=2
        v = vf; %final velocities from collision 1 become initial velocities
        v(1) = V(x,y,v); % final velocity for cart 1
        v(2) = V(x,y,v); %final velocity for cart 2

        checkPf = totalP-sum(m.*v); %checking via momentum, should be 0
        checkEf = totalE-sum(0.5*m.*v.^2); % checking via energy, should be 0
    end
    if vf(2) > vf(3) %if cart 2 and 3 are gonna collide
        v = vf; %final velocities become initial velocities
        v = [0 0 0]; %initializing array for 2nd collision
        v(1) = v(1); %cart 1 not involved, velocity remains same
        v(2) = V(m(2), m(3), v(2), v(3)); % final velocity for cart 2
        v(3) = vf2(m(2), m(3), v(2), v(3)); %final velocity for cart 3

    
        checkPf = totalP-sum(m.*v); %checking via momentum, should be 0
        checkEf = totalE-sum(0.5*m.*v.^2); %checking via energy, should be 0
    end
    i = i + 1;
    vf = v;
    disp("Collision " + i)
    vf
    checkPf
    checkEf
end
disp(i + " Total Collisions" + newline +  "Final Velocities:")
vf
m;
%--------functions-----------

function vf = V(x,y,v)
global m
    vf = ((m(x)-m(y))*v(x) + 2*m(y)*v(y))/(m(x)+m(y));
end


