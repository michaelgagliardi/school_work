clear 
close all
f = @(t,v) 9.8-0.029166667*v^2;
tt = [0 10];
v_in = 55.555556;
h = [0.5 0.1 0.01];
for i = 1:length(h)
    
    hh=h(i);
    [t_elr, v_elr] = euler(f,tt,v_in,hh);
    hold on
    plot(t_elr,v_elr)
    
end
xlabel('Time in s')
ylabel('Velocity in m/s')
title('Time vs. Velocity')
function [t,y]=euler(f,tt,y_in,h)
    t_in=tt(1); t_end=tt(2);
    t(1)=t_in; y(1)=y_in;
    t_max = t_end;
    N=(t_max-t_in)/h;
    fprintf('For step size T=%d\n',N)
    for i = 1:N
        t(i+1)=t_in+i*h;
        y(i+1)=double(y(i)+h*(f(t(i),y(i))));
    
        if i<=5
            fprintf('\t Using Euler method at t=%f vale of y(t)=%f\n',t(i+1),y(i+1))
        end
    end
    fprintf('/n')
end

    

