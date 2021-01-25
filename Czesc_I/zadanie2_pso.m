zadanie1;

[x, fval] = pso(@Himmelblau, 2, [], [], [], [], [-5 -5], [5 5]);

hold on;
plot3(x(1), x(2), fval, "r*");
hold off;

% Found solutions
% [-2.8051 3.1313]
% [3 2] 0
% [3.5844 -1.8481]
% [-3.7793 -3.2832]