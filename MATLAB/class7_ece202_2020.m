% Michael Gagliardi
% 9.7.2020
% ECE 202 Fall 2020, class 7
% creating and plotting functions

% focus on charging capacitor: v(t) = 12 (1 - exp(-t/40))

clear
clf % clears figures

t = linspace(0,200,401); % in s, 200 = 5*tau
v = 12*(1 - exp(-t/40)); % in V, v(t)

n = 1:401; % indez n, to go with t and v

vtTable = [n; t; v].'; % turn three rows into three columns (simple table)

% more elaborate table, with headings

vtTable = table(n.', t.', v.', 'VariableNames', ... % continuation symbol
    {'Index', 'Time (s)', 'Voltage (V)',});

plot(t,v, 'b', 'lineWidth', 3) % x, then y, thicker, blue line

axis([-inf inf 0 14])

ax = gca; %current axes or chart
ax.FontSize = 12; % change everything to 12 pt fonts


xlabel('time t(s)', 'FontSize', 15 ) % use words as labels wherever possible, add unit abbreviation
ylabel('voltage v(V)', 'FontSize', 15) 

title('ECE 202 Class #7: Voltage Across Charging Capacitor')

grid on % adds a grid
ax.GridAlpha = 0.3; %makes grid slightly darker


