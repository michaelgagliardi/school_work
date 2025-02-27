% Michael Gagliardi 1/8/2021 ECE 202 Winter 21 MATlab Exercise 5
% Equations from: Carl R. (Rod) Nave; Department of Physics and Astronomy; Georgia... 
% State University
% http://hyperphysics.phy-astr.gsu.edu/hbase/colsta.html
% Three carts of different masses and different velocities are travelling
% along the same line. They collide elastically.
clear

%------given information ------------
global m
m = input('Enter three masses surrounded by brackets: ');
v = input('Enter three velocities surrounded by brackets: ');
totalP = sum(m.*v); % total momentum of the system
totalE = sum(0.5*m.*v.^2); % total energy of the system

%----------- collisons ---------------
i = 0;
while v(1) > v(2) || v(2) > v(3)

    if v(1) > v(2) %if cart 1 and 2 are gonna crash
        col = 12;
    end
    
    if v(2) > v(3) %if cart 1 and 2 are gonna crash
       col = 23;
    end
    
    if v(1) > v(2) && v(2)>v(3)
        col = input('Which collision occurs first? "12" for 1 & 2, "23" for 2 & 3: ');
        %if both carts will colide, specify which collision occurs first
    end
    
    i = i + 1; %adds 1 to collision counter
    disp("Collision " + i) %display collsion number
    v = collision(col,v) %calls user defined function
    checkPf = totalP-sum(m.*v); %checking via momentum, should be 0
    checkEf = totalE-sum(0.5*m.*v.^2); % checking via energy, should be 0
        
    if abs(checkPf) || abs(checkEf) > 1e-10 %insuring conservation
        disp("An error has occured, momentum or energy not conserved")
        checkPf  %output check if error
        checkEf  %output check if error
    end
end
if i == 0
    fprintf("There are no collisions.") %if the user inputted values don't collide
else
    fprintf(i + " Total Collisions" + newline +  "Final Velocities:") %outputting finals
    v
    checkPf
    checkEf
end
%-------- final velocity function-----------

function vf = collision(col,v0) %final velocity function, updates entire array
global m
m12 = m(1) + m(2);
m23 = m(2) + m(3);
    if col == 12
        vf(1) = ((m(1)-m(2))*v0(1) + 2*m(2)*v0(2))/m12;
        vf(2) = ((m(2)-m(1))*v0(2) + 2*m(1)*v0(1))/m12;
        vf(3) = v0(3);
    end
    if col == 23
        vf(2) = ((m(2)-m(3))*v0(2) + 2*m(3)*v0(3))/m23;
        vf(3) = ((m(3)-m(2))*v0(3) + 2*m(2)*v0(2))/m23;
        vf(1) = v0(1);
    end
end


