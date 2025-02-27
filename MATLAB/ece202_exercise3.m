% Michael Gagliardi 12/7/2020 ECE 202 2020 MATlab Exercise 3
% Equations from: Carl R. (Rod) Nave; Department of Physics and Astronomy; Georgia... 
% State University
% http://hyperphysics.phy-astr.gsu.edu/hbase/colsta.html
% Two carts of different masses and different velocities are travelling
% along the same line. They collide elastically.
clear
%------given information -------

m = [240 120 360]; % masses of cart 1, cart 2, and cart 3 in grams
vi = [30 15 -45]; % inital velocities of cart 1, cart 2, and cart 3 in cm/s
M12 = m(1)+m(2); % mass of carts 1 and 2 for collision 1
M23 = m(2)+m(3); % mass of carts 2 and 3 for collision 2
p0 = sum(m.*vi); % total momentum of the system
E0 = sum(0.5*m.*vi.^2); % total energy of the system

%--------first collsion -----------

vA = [0 0 0]; %initializing array for first collision
vA(1) = vi(1); %cart 1 is not in first collision, velocity stays same
vA(2) = ((m(2)-m(3))*vi(2) + 2*m(3)*vi(3))/M23; % final velocity for cart 2
vA(3) = ((m(3)-m(2))*vi(3) + 2*m(2)*vi(2))/M23 %final velocity for cart 3

% ------checking the first collision--------
checkP_A = p0-sum(m.*vA)
checkE_A = E0-sum(0.5*m.*vA.^2)

%----------- second collison ----------

if vA(1) > vA(2) || vA(2) > vA(3) %if there is another collision
    disp("There is another collision")
    vB = [0 0 0]; %%initialize array for 2nd collision
    vB(3) = vA(3); %collision 2 does not involve cart 3, velocity remains same
    vB(1) = ((m(1)-m(2))*vA(1) + 2*m(2)*vA(2))/M12; % final velocity for cart 1
    vB(2) = ((m(2)-m(1))*vA(2) + 2*m(1)*vA(1))/M12 %final velocity for cart 2
    
    checkP_B = p0-sum(m.*vB) %checking via momentum, should be 0
    checkE_B = E0-sum(0.5*m.*vB.^2) % checking via energy, should be 0

else 
    disp("There are no more collisions, 1 total collision") %display if there is not another collision
end

%------third collision--------
if vB(1) > vB(2) || vB(2) > vB(3)%if there is another collision
    disp("There is another collision")
    vC = [0 0 0]; %initializing array for 3rd collision
    vC(1) = vB(1);%collision 3 does not involve cart 1, velocity remains same
    vC(2) = ((m(2)-m(3))*vB(2) + 2*m(3)*vB(3))/M23; % final velocity for cart 2
    vC(3) = ((m(3)-m(2))*vB(3) + 2*m(2)*vB(2))/M23 %final velocity for cart 3
    
    checkP_C = p0-sum(m.*vC) %checking via momentum, should be 0
    checkE_C = E0-sum(0.5*m.*vC.^2)  %checking via energy, should be 0

else
    disp("There are no more collisions, 2 total collisions")%display if there is not another collision
end

%-----fourth collision---------
if vC(1) > vC(2) || vC(2) > vC(3)%if there is another collision
    disp("There is another collision")
    vD = [0 0 0]; %initializing array for 4th collision
    vD(3) = vC(3);%collision 4 does not involve cart 3, velocity remains same
    vD(1) = ((m(1)-m(2))*vC(1) + 2*m(2)*vC(2))/M12; % final velocity for cart 1
    vD(2) = ((m(2)-m(1))*vC(2) + 2*m(1)*vC(1))/M12 % final velocity for cart 2

    checkP_D = p0-sum(m.*vD) %checking via momentum, should be 0
    checkE_D = E0-sum(0.5*m.*vD.^2)%checking via energy, should be 0

else
    disp("There are no more collisions, 3 total collisions")%display if there is not another collision
end

%---------fifth collision--------
if vD(1) > vD(2) || vD(2) > vD(3)%if there is another collision
    disp("There is another collision")
    vE = [0 0 0]; %initializing array for 5th collision
    vE(1) = vD(1); %collision 5 does not involve cart 1, velocity remains same
    vE(2) = ((m(2)-m(3))*vD(2) + 2*m(3)*vD(3))/M23; % final velocity for cart 2
    vE(3) = ((m(3)-m(2))*vD(3) + 2*m(2)*vD(2))/M23 %final velocity for cart 3
    
    checkP_E = p0-sum(m.*vE) %checking via momentum, should be 0
    checkE_E = E0-sum(0.5*m.*vE.^2)
else
    disp("There are no more collisions, 4 total collisions") %display if there is not another collision
end
    