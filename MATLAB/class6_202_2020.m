% Michael Gagliardi
% 9.4.2020
% ECE 202 Fall 2020, class 6
% solving a circuits problem with one source and three resistors

clear


% ------- givens ------

v0 = 18; % independent coltage source, in V
R = [ 4 6 3]; % 3 resistor values in ohm


% ------ calculations --------

R23eq = R(2)* R(3)/(R(2)+R(3)); % R2 || R3
Req= R(1) + R23eq; 

% part (a) calculate currents

i = [0,0,0]; %initialize current array, in A

i(1) = v0/Req; % one source, eq, resistance (suppress output)
i(2) = i(1) * R(3)/(R(2)+R(3)); % current divider (suppressed)
i(3) = i(1) * R(2)/(R(2)+R(3)) % current divider 

% part (b) calculate voltages

v = R .* i % voltage array for all three resistors

% ------ checks (and some more calculations) ----

% part (c)

KCLcheck = i(1)-(i(2) + i(3)) %i1 = i2 +i3

KVLcheck_left = v0 - v(1) - v(2) % left mesh, should be 0
KVLcheck_right = v(2) - v(3) % right mesh, also 0

% part (d) calculate power absorbed using vi

p_abs = v .* i % power absorved by each R, in W

% v .* i == [v1*i1 v2*i2 v3*i3] 

% part (e) check p_abs using R*i^2 and v^2/R

checkPowerAbs_with_R_and_i = p_abs - R .* i.^2 %an array of zeros
checkPowerAbs_with_R_and_v = p_abs - v.^2 ./ R % an array of zeros

% part (f) calculate power delivered by v0, check power balance

p_del = v0 * i(1)

checkPowerBalance = p_del - sum(p_abs) % should be 0


% We can make this more efficient by defining R23 = R(2) + R(3), used 3
% times
% You dont need to understand circutios to understand how arrays anddot
% operations make this more efficent

%We are using semicolons in lines 24 and 25 to suppress outputs , because
%we were not done defining the array i. But there is no semicolon at the
%end of line 26, allowing all three elements of array i to output even
%though line 26 is only defining i(3).



