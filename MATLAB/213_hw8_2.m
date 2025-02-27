clear
r1 = 500;
r2 = 2000;
c = 3.3*10^-7;
thingy = 500/((500+2000)*(1i*400*pi*c)+1);
n = 1:5;

vout1 = tcheckPowerAbs_with_R_and_ihingy * (-1^2)*(2*.02/(1)*pi)*sin(2*(1)*pi*t/0.005)+.02
vout2 = thingy * ((-1^3)*(2*.02/((2)*pi))*sin(2*(2)*pi*t/0.005)+.02) + vout1
vout3 = thingy * ((-1^4)*(2*.02/((3)*pi))*sin(2*(3)*pi*t/0.005)+.02) + vout2
vout4 = thingy * ((-1^5)*(2*.02/((4)*pi))*sin(2*(4)*pi*t/0.005)+.02) + vout3
vout5 = thingy * ((-1^6)*(2*.02/((5)*pi))*sin(2*(5)*pi*t/0.005)+.02) + vout4
