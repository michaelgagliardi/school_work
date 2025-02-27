%Matlab code for infinite series
clear all
close all

%all given data
t=linspace(0,0.2,400);
ft=12*cos(40.*t);
%plotting the data
plot(t,ft,'linewidth',3)
lgnd{1}='Actual Data';
hold on
t1=linspace(0,0.2,400);
%loop for infinite series
i=1;
pp=polyfit(t,ft,i);
pvl=polyval(pp,t1);
fprintf('\nFor %d terms, coefficients are \n',i+2)
disp(flip(pp))
plot(t1,pvl)
lgnd{i+1}=sprintf('upto %d terms',i+1);
i=2;
pp=polyfit(t,ft,i);
    pvl=polyval(pp,t1);
    fprintf('\nFor %d terms, coefficients are \n',i+2)
    disp(flip(pp))
    plot(t1,pvl)
    lgnd{i+1}=sprintf('upto %d terms',i+1);
i=3;
pp=polyfit(t,ft,i);
    pvl=polyval(pp,t1);
    fprintf('\nFor %d terms, coefficients are \n',i+2)
    disp(flip(pp))
    plot(t1,pvl)
    lgnd{i+1}=sprintf('upto %d terms',i+1);
i=4;
pp=polyfit(t,ft,i);
    pvl=polyval(pp,t1);
    fprintf('\nFor %d terms, coefficients are \n',i+2)
    disp(flip(pp))
    plot(t1,pvl)
    lgnd{i+1}=sprintf('upto %d terms',i+1);
i=5;
pp=polyfit(t,ft,i);
    pvl=polyval(pp,t1);
    fprintf('\nFor %d terms, coefficients are \n',i+2)
    disp(flip(pp))
    plot(t1,pvl)
    lgnd{i+1}=sprintf('upto %d terms',i+1);
i=6;
pp=polyfit(t,ft,i);
    pvl=polyval(pp,t1);
    fprintf('\nFor %d terms, coefficients are \n',i+2)
    disp(flip(pp))
    plot(t1,pvl)
    lgnd{i+1}=sprintf('upto %d terms',i+1);


xlabel('t')
ylabel('f(t)')
legend(lgnd,'location','best')
title('Plotting of actual data and all infinite series')
box on
%%%%%%%%%%%%% End of Code %%%%%%%%%%%%%

