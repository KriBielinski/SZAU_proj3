function PID_plot(X)
    % Parametry procesu
    a1 = -1.599028;
    a2 = 0.632337;
    b1 = 0.010754;
    b2 = 0.009231;

    % Parametry Symulacji
    kk = 1000;

    u(1:kk) = 0;
    x1(1:kk) = 0;
    x2(1:kk) = 0;
    y(1:kk) = 0;
    e(1:kk) = 0;

    % Wartość zadana
    y_zad(1:kk) = 0;
    y_zad(100:kk) = 1;
    y_zad(200:kk) = -0.5;
    y_zad(300:kk) = -1;
    y_zad(400:kk) = 0.2;
    y_zad(500:kk) = 0.6;
    y_zad(600:kk) = -0.2;
    y_zad(700:kk) = 0.8;

    % Parametry PID
    T = 1;
    K = X(1);
    Ti = X(2);
    Td = X(3);
    r1 = K * (1 + T/(2*Ti) + Td/T);
    r2 = K * (T/(2*Ti) - 2*Td/T - 1);
    r3 = K * Td/T;

    % Pętla regulacji
    for k=5:kk
        % Obiekt
        x1(k) = -a1*x1(k-1) + x2(k-1) + b1*g1(u(k-4));
        x2(k) = -a2*x1(k-1) + b2*g1(u(k-4));
        y(k) = g2(x1(k));

        % Blad
        e(k) = y_zad(k) - y(k);

        % Regulator
        u(k) = u(k-1) + r1*e(k) + r2*e(k-1) + r3*e(k-2);

        if u(k) > 1
            u(k) = 1;
        end

        if u(k) < -1
            u(k) = -1;
        end
    end
    
    % Liczenie Bledu
    E = 0;
    for k=1:kk
        E = E + (y_zad(k)-y(k))^2;
    end

    % Rysunki
    figure;
    plot(y_zad);
    hold on;
    plot(y);
    hold off;
    legend("y^{zad}", "y obiektu");
    titl = sprintf("K=%.4f, T_i=%.4f, T_d=%.4f, E=%.4f", K, Ti, Td, E);
    title(titl);

    figure;
    plot(u);
    title("Sterowanie");
    % figure;
    % plot(u);
end