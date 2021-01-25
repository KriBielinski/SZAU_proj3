clear all;

[X, fval] = pso(@PID_fun, 3, [], [], [], [], [-10 0 0], [0 100 100]);

PID_plot(X);
disp(fval);

% Dobre Wyniki
% [-0.39493 15.834 1.0385] 52.682876500148204