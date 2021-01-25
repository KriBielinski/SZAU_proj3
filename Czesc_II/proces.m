% Zwykła symulacja procesu

a1 = -1.599028;
a2 = 0.632337;
b1 = 0.010754;
b2 = 0.009231;

kk = 100;

u(1:kk) = 0;
u(10:kk) = 1;

x1(1:kk) = 0;
x2(1:kk) = 0;

y(1:kk) = 0;

for k=5:kk
    x1(k) = -a1*x1(k-1) + x2(k-1) + b1*g1(u(k-4));
    x2(k) = -a2*x1(k-1) + b2*g1(u(k-4));
    y(k) = g2(x1(k));
end

plot(y);