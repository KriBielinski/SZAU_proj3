clear all

[X, fval] = ga(@NPL_fun, 3, [], [], [], [], [10 1 1], [14 6 6], [], [1 2 3]);

%[X, fval] = pso(@NPL_fun, 3, [], [], [], [], [10 1 1], [14 6 6]);

NPL_plot(X);