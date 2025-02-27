% BL
% 10/16/20
% class 24 (from class 20)
% constructing a function from its SECOND derivative
% adding subplots

clear; clf;

tmin = 0; tmax = 7; N = 400;   % given
A = 1; w = 1;  % w in rad/s
f0 = 0;   % initial value f(0)
fp0 = -1;   % initial value of f'(t), i.e., f'(0), f-prime = fp

t = linspace(tmin, tmax, N+1);   % N intervals
dt = (tmax-tmin)/N;
fpp = A*sin(w*t);

f = zeros(1, N+1);
fp = zeros(1, N+1);  % initializing f(t) and f'(t)

f(1) = f0;
fp(1) = fp0;

%f(2) = f(1) + fp(1)*dt + (1/2)*fpp(1)*dt^2;
%fp(2) = fp(1) + fpp(1)*dt;

for n = 1:N   % stop at N, to compute f(N+1) and f'(N+1)
    
    f(n+1) = f(n) + fp(n)*dt + (1/2)*fpp(n)*dt^2;
    fp(n+1) = fp(n) + fpp(n)*dt;
    
end

% ----- use subplots -----

% subplot #1

subplot(3,1,1)    % 3 x 1 array of subplots, plot #1

plot(t, fpp, 'b', 'LineWidth', 2)
grid on

ax = gca; ax.FontSize = 15; ax.GridAlpha = 0.3;

%xlabel('time t (s)', 'FontSize', 18)
ylabel('f^{\prime\prime}(t)', 'FontSize', 18)

% no title is needed either -- see SGTITLE below

%title({'ECE 202, Class 24:', ...
 %   'Constructing a function from its second derivative', ''}, ...
  %  'FontSize', 24)   % make the text BOLD

% use a RECTANGLE command to cover up the gridlines

rectangle('Position', [5.1, 1.5, 1.8, 1], ...   % [x0, y0, dx, dy]
    'FaceColor', 'w', 'EdgeColor', 'k')   % white box, black border

% add a "subtitle" using TEXT command

%text(6, 2, 'f^{\prime\prime}(t) = sin(t)', ...
 %   'HorizontalAlignment', 'center', 'FontSize', 18)

text(6, 2, sprintf('f^{\\prime\\prime}(t) = %gsin(%gt)', A, w), ...
    'HorizontalAlignment', 'center', 'FontSize', 18)

%legend({'d^2f/dt^2 = sin(t), given', 'df/dt, numerical', ...
%    'f(t), numerical'}, 'FontSize', 18)

ylim([-2 3])


% subplot #2

subplot(3,1,2)   % 2nd of 3 subplots (middle)

plot(t, fp, 'r', 'LineWidth', 2)
grid on

ax = gca; ax.FontSize = 15; ax.GridAlpha = 0.3;

%xlabel('time t (s)', 'FontSize', 18)
ylabel('f^{\prime}(t)', 'FontSize', 18)

rectangle('Position', [5.1, 1.5, 1.8, 1], ...   % [x0, y0, dx, dy]
    'FaceColor', 'w', 'EdgeColor', 'k')   % white box, black border

%text(6, 2, 'f^{\prime}(0) = -1', ...
 %   'HorizontalAlignment', 'center', 'FontSize', 18)

text(6, 2, sprintf('Given: f^{\\prime}(0) = %g', fp0), ...
    'HorizontalAlignment', 'center', 'FontSize', 18)

ylim([-2 3])


% subplot #3

subplot(3,1,3)   % 3rd of 3 subplots (bottom)

plot(t, f, 'k', 'LineWidth', 4)
grid on

ax = gca; ax.FontSize = 15; ax.GridAlpha = 0.3;

xlabel('time t (s)', 'FontSize', 18)   % need an X label
ylabel('f(t)', 'FontSize', 18)

rectangle('Position', [5.1, 1.5, 1.8, 1], ...   % [x0, y0, dx, dy]
    'FaceColor', 'w', 'EdgeColor', 'k')   % white box, black border

%text(6, 2, 'f(0) = 0', ...
 %   'HorizontalAlignment', 'center', 'FontSize', 18)

text(6, 2, sprintf('Given: f(0) = %g', f0), ...
    'HorizontalAlignment', 'center', 'FontSize', 18)

ylim([-2 3])



% use SGTITLE for the overall title of the array of subplots

sgtitle({'ECE 202, Class 24:', ...
    'Constructing a function from its second derivative'}, ...
    'FontSize', 24, 'FontWeight', 'b')   % make the text BOLD








