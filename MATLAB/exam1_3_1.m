a = input("Enter value a: "); %inputting value for a
b = input("Enter value b: "); %inputting value for b
w = 100; % angular velocity in rad/s
wt = w*t; %establishing variable used multiple times

%-------computations ---------

K = sqrt(a^2 + b^2); % calculating value of amplitude

if a > 0 
    pa = atan2(-b,a) %phase angle if a > 0
else
    pa = pi + atan2(-b,a) %phase angle if a < 0
end


