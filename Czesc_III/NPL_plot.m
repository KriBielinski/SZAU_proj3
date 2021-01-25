function NPL_plot(X)

    load('Z4_Wybranymodel/_blad_0.35209_lp_5_.mat');

    dlugosc_danych=2500;
    simtime=dlugosc_danych;
    err_wer=0;
    Yzad=zeros(1,dlugosc_danych);
    X_obiekt=zeros(2,dlugosc_danych);
    Y_obiekt=zeros(1,dlugosc_danych);
    U_obiekt=zeros(1,dlugosc_danych);


    %% Parametry regulatora
    N=floor(X(1));
    Nu=floor(X(2));
    lambda=floor(X(3));

    delta_U=0.1;


    delta_linearyzacji=10^(-7);

    Yzad(100:simtime)=0.0;
    Yzad(200:simtime)=1.0;
    Yzad(300:simtime)=1.0;
    Yzad(400:simtime)=0.5;
    Yzad(500:simtime)=0.8;
    Yzad(600:simtime)=2.10;
    Yzad(700:simtime)=1.15;
    Yzad(800:simtime)=3.15;
    Yzad(900:simtime)=-0.8;
    Yzad(1000:simtime)=2.0;
    Yzad(1100:simtime)=1.8;
    Yzad(1300:simtime)=-0.7;
    Yzad(1400:simtime)=0.6;
    Yzad(1800:simtime)=-0.8;
    Yzad(2100:simtime)=0.8;
    Yzad(2400:simtime)=0.023;





    for k=6:dlugosc_danych

        %% symulacja
        [X_obiekt(:,k), Y_obiekt(k)]= Proces(X_obiekt(:,k-1),U_obiekt(k-4));


        %% NPL Krok2
        qk=[U_obiekt(k-4) U_obiekt(k-5) Y_obiekt(k-1) Y_obiekt(k-2) ]';
        Ymod=w20+w2*tanh(w10+w1*qk);
        dk=Y_obiekt(k)-Ymod;

        %% NPL Krok3 Generacja trajektorii

        Y0k=zeros(N,1);
        for i=1:N
            Zad4_Y0k_gen
            qk=[Usw1 Usw2 Ysw1 Ysw2]';
            Ymod=w20+w2*tanh(w10+w1*qk);
            Y0k(i)=dk+Ymod;
        end
        %% NPL Krok4 Linearyzacja Modelu
            Zad4_lin_num_gen

         %% NPL Krok5 Odpowiedz skokowa na podstawie zmiennych wspolczynnikow
        Sk=zeros(1,N);
        U_odp_skokowa=zeros(1,N+6);
        Y_odp_skokowa=zeros(1,N+6);
        U_odp_skokowa(6:N+6)=1;

        for i=6:N+6
          Sk(i-4)= b3*U_odp_skokowa(i-4) + b4*U_odp_skokowa(i-5) + a1*Y_odp_skokowa(i-1) + a2 * Y_odp_skokowa(i-2);
          Y_odp_skokowa(i)=Sk(i-4);
        end

        Mk=zeros(N,Nu);

        for i=1:N
           for ii=1:Nu
            tmp_sk=0;
               if i-ii+1>=1
                   tmp_sk=Sk(i-ii+1);
               end
           Mk(i,ii)=tmp_sk;    
           end
        end

        Kk=inv((Mk.'*Mk)+(lambda*eye(Nu,Nu)))*Mk.';

        %% NPL Krok6 Obliczanie dUk
        YzadM=ones(N,1).*Yzad(k);

        dUkk=Kk*(YzadM-Y0k);
        dUkk=dUkk(1);

        %% Ograniczenia
        if dUkk>delta_U
            dUkk=delta_U;
        elseif dUkk< -delta_U
            dUkk=-delta_U;
        end
        U_obiekt(k)=dUkk+U_obiekt(k-1);
        if U_obiekt(k)>1
            U_obiekt(k)=1;
        end
        if U_obiekt(k)<-1
            U_obiekt(k)=-1;
        end


    end
    %% Liczenie Blędu
    Err=sum((Yzad-Y_obiekt).^2)
    
    figure; stairs(Y_obiekt,'b'); hold on; stairs(Yzad,'r'); xlabel('Iteracje'); ylabel('Dane z modelu, Wartosci zadane'); legend('Ymod','Yzad');
    titl = sprintf("N=%d, N_u=%d, lambda=%d, E=%.4f", N, Nu, lambda, Err);
    title(titl);
    title(titl);
    figure; stairs(U_obiekt); xlabel('Iteracje')
end