% Michael Gagliardi
%9/9/20

% useful commands for Project 1
 
% string command, multiline title, make the title "robust"


% damped sinusoid: h(t) - 12 exp(t/4) cos(5t

tmin = 0; tmax = 15 % in s
N = 400; % intervals

t = linspace(tmin, tmax, 1+N) % 401 points

a = 12; tau = 4; w = 5; % tau, time constant, in s; angular freq., in rad/s
 
h = a * exp(-t/tau) .* cos(w*t);

plot(t, h, 'LineWidth', 2)

ax = gca;
ax.FontSize = 15;

grid on 
ax.GridAlpha = 0.3;

xlabel('time(s)', 'FontSize', 18)
ylabel('h(t)', 'FontSize', 18)

title({'ECE 202, Class 8: Damped Sinusoid', ...
    sprintf('h(t) = %g exp(-t/%g) cos(%gt)', a, tau, w)}, ...
    'FontSize', 22)

