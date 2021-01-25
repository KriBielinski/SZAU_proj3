clear all;

point_num = 100;

y_tab = zeros(point_num, point_num);
x1_tab = linspace(-5, 5, point_num);
x2_tab = linspace(-5, 5, point_num);

for i=1:point_num
    for j=1:point_num
        y_tab(i,j) = Himmelblau([x1_tab(j), x2_tab(i)]);
    end
end

surfl(x1_tab, x2_tab, y_tab);
title("Funkcja Himmelblau");
xlabel("x_1");
ylabel("x_2");
zlabel("y");