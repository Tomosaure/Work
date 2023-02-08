close all;
clear all;

%% Déclaration des variables
Nb_bits = 10000;
Fp = 2e3;
ALPHA = 0.35;
Fe = 10e3;
Rb = 2e3;
Rs = Rb;
M = 4;
Ts = log2(M) / Rb;
Te = 1/Fe;
Ns = Fe*Ts;
SPAN = 8;

%% Utilisation de la chaine passe-bas équivalente pour le calcul et l'estimation du taux d'erreur binaire

%% Implantation de la chaine sur frequence porteuse 

%% Génération des bits
bits = randi([0,1],1,Nb_bits);

%% Mapping
ak = 2*bits(1:2:end)-1;
bk = 2*bits(2:2:end)-1;
dk = ak + 1i*bk;
scatterplot(dk);
title("Constellation en sortie du mapping")
xlim([-2 2]);
ylim([-2 2]);

%% Génération du train de Diracs
Suite_diracs = kron(dk, [1 zeros(1,Ns-1)]);

%% Filtre mise en forme
h1 = rcosdesign(ALPHA,SPAN,Ns,'sqrt');
retard = SPAN*Ns/2;
Xe = filter(h1, 1, [Suite_diracs,zeros(1,retard)]);
Xe = Xe(retard+1:end);

%% Tracer les signaux générés sur les voies en phase et en quadrature ainsi que le signal transmis sur fréquence porteuse.

figure("Name", "Generation du signal Xe");
% les voies en phase
subplot(2,1,1);
plot(real(Xe));
axis([0 length(Xe) -1 1]);
xlabel("Fréquence en Hz")
title('Generation du signal Xe: Partie réelle');
% les voies en quadrature
subplot(2,1,2);
plot(imag(Xe));
axis([0 length(Xe) -1 1]);
xlabel("Fréquence en Hz")
title('Generation du signal Xe: Partie imaginaire');

%% Transposition de frequence
t = (0:length(Xe)-1)*Te;
X = real(Xe.*exp(2*1i*pi*Fp*t));
figure("Name", "signal X transmis sur fréquence porteuse");
plot(X);
axis([0 length(Xe) -1 1]);
xlabel("Fréquence en Hz")
title("signal X transmis sur fréquence porteuse");

%% --3.1.2 Estimer et tracer la densité spectrale de puissance du signal modulé sur fréquence porteuse.

% DSP
figure("Name", "DSP du signal modulé sur fréquence porteuse");
DSP = abs(fft(X)).^2;
abscisse = -Fe/2:Fe/length(DSP):Fe/2-Fe/length(DSP);
semilogy(abscisse,fftshift(DSP));
xlabel("Fréquences en Hz");
ylabel("DSP");
title('DSP sur fréquence porteuse');

%% Implanter la chaine complète sans bruit afin de vérifier que le TEB obtenu est bien nul.

%% Retour en bande de base
Z1 = X.*cos(2*pi*Fp*t);
Z2 = X.*sin(2*pi*Fp*t);

%% Filtre passe-bas
h_passe_bas = ones(1,3);
Z1 = filter(h_passe_bas, 1, Z1);
Z2 = filter(h_passe_bas, 1, Z2);
Z = Z1 -1i*Z2;

%% Demodulation en bande de base

% Filtre de receception
hr = h1;
Z_r = filter(hr, 1, [Z,zeros(1,retard)]);
Z_r = Z_r(retard+1 : end);

% Diagramme de l'oeil
figure('Name', "Diagramme de l'oeil");
plot(reshape(Z_r(Ns+1:end),Ns,length(Z_r(Ns+1:end))/Ns));
grid on;

% Echantillonnage

Z_ech = Z_r(1:Ns:end);

% Decision et Demapping
Z_decide = zeros(1,Nb_bits);
Z_decide(1:2:end) = (sign(real(Z_ech))+1)/2;
Z_decide(2:2:end) = (sign(imag(Z_ech))+1)/2;

% TEB sans bruit
TEB = length(find(bits ~= Z_decide))/length(bits);
fprintf("TEB de la chaine sur fréquence porteuse sans bruit : %f \n", TEB);

%% TEB avec bruit
Eb_N0 = zeros(1,7);
TEB_bruit = zeros(1,7);
for i = 1:7

    bits_erronnes = 0;
    bits_total = 0;

    while bits_erronnes < 1000

        % Génération des bits
        bits = randi([0,1],1,Nb_bits);

        % Mapping
        ak = 2*bits(1:2:end)-1;
        bk = 2*bits(2:2:end)-1;
        dk = ak + 1i*bk;

        % Génération du train de Diracs
        Train_diracs = kron(dk, [1 zeros(1,Ns-1)]);

        % Filtre mise en forme
        h1 = rcosdesign(ALPHA,SPAN,Ns,'sqrt');
        retard = SPAN*Ns/2;
        Xe = filter(h1, 1, [Train_diracs,zeros(1,retard)]);
        Xe = Xe(retard+1:end);

        % Transposition de frequence
        t = (0:length(Xe)-1)*Te;
        X = real(Xe.*exp(2*1i*pi*Fp*t));

        % Ajout du bruit
        Px = mean(abs(X).^2);
        Eb_N0(i) = 10^((i-1)/10);
        sigma2 = (Px*Ns)/(2*log2(M)*Eb_N0(i));
        bruit = sqrt(sigma2)*randn(1,length(X));
        X_bruit = X + bruit;

        % Retour en bande de base
        Z1_bruit = X_bruit.*cos(2*pi*Fp*t);
        Z2_bruit = X_bruit.*sin(2*pi*Fp*t);

        % Filtre passe-bas
        Z1_bruit = filter(h_passe_bas, 1, Z1_bruit);
        Z2_bruit = filter(h_passe_bas, 1, Z2_bruit);
        Z_bruit = Z1_bruit -1i*Z2_bruit;

        % Filtre de receception
        hr = h1;
        Z_bruit = filter(hr, 1, [Z_bruit,zeros(1,retard)]);
        Z_bruit = Z_bruit(retard+1 : end);

        % Echantillonnage
        Z_ech_bruit = Z_bruit(1:Ns:end);

        % Decision et Demapping
        Z_decide_bruit = zeros(1,Nb_bits);
        Z_decide_bruit(1:2:end) = (sign(real(Z_ech_bruit))+1)/2;
        Z_decide_bruit(2:2:end) = (sign(imag(Z_ech_bruit))+1)/2;
    
        % TEB
        erreur = sum(abs(Z_decide_bruit-bits));
        bits_erronnes = bits_erronnes + erreur;
        bits_total = bits_total + Nb_bits;
    end

        TEB_bruit(i)= bits_erronnes/bits_total;
end

figure("Name","TEB de la chaine sur fréquence porteuse avec bruit");
semilogy(0:6,TEB_bruit,'--o');
hold on
semilogy(0:6,qfunc(sqrt(2*Eb_N0)));
hold on
title("Signal avec bruit: TEB simule et TEB theorique");
xlabel("Eb/N0 (dB)");
ylabel("TEB");
legend("TEB-simule", "TEB-theorique");

%% Implantation de la chaine passe-bas équivalente

%% Tracer les signaux générés sur les voies en phase et en quadrature
figure("Name", "Generation du signal Xe");
% les voies en phase
subplot(2,1,1);
plot(real(Xe));
axis([0 length(Xe) -1 1]);
xlabel("Fréquence en Hz")
title('Generation du signal Xe: Partie réelle');
% les voies en quadrature
subplot(2,1,2);
plot(imag(Xe));
axis([0 length(Xe) -1 1]);
xlabel("Fréquence en Hz")
title('Generation du signal Xe: Partie imaginaire');

%% Estimer puis tracer la densité spectrale de puissance de l’enveloppe complexe associée au signal modulé sur fréquence porteuse.
% DSP de Xe
figure("Name", "DSP du signal Xe");
DSP_Xe = abs(fft(Xe)).^2;
abscisse_Xe = -Fe/2:Fe/length(DSP_Xe):Fe/2-Fe/length(DSP_Xe);
semilogy(abscisse,fftshift(DSP_Xe));
xlabel("Fréquence en Hz")
ylabel("DSP")
title('DSP\_Xe');

figure("Name","Comparaison des 2 DSPs");
semilogy(abscisse,fftshift(DSP));
hold on;
semilogy(abscisse_Xe,fftshift(DSP_Xe));
hold on;
title("Comparaison entre les deux DSPs des deux parties");
xlabel("Fréquences en Hz");
ylabel("DSP");
legend("Fréquence porteuse","Passe-bas équivalente");


%% Implanter la chaine complète sans bruit afin de vérifier que le TEB obtenu est bien nul.

% Filtre de receception
hr = h1;
X_r2 = filter(hr, 1, [Xe zeros(1,retard)]);
X_r2 = X_r2(retard+1 : end);

% Echantillonnage
X_ech2 = X_r2(1:Ns:end);

% Decision et Demapping
X_decide2 = zeros(1,Nb_bits);
X_decide2(1:2:end) = (sign(real(X_ech2))+1)/2;
X_decide2(2:2:end) = (sign(imag(X_ech2))+1)/2;

% TEB sans bruit
TEB_sans_bruit2 = length(find(bits ~= X_decide2))/length(bits);
fprintf("TEB de la chaine passe-bas équivalente sans bruit : %f \n", TEB_sans_bruit2);

%% Rajouter le bruit et tracer le taux d6erreur binaire obtenu en fonction du rapport signal à bruit par bit à l’entrée du récepteur (E b /N 0) en décibels.
% TEB avec bruit
TEB_bruit2 = zeros(1,7);
for i = 1:7

    bits_erronnes = 0;
    bits_total = 0;

    while bits_erronnes < 100

        % Génération des bits
        bits = randi([0,1],1,Nb_bits);

        % Mapping
        ak = 2*bits(1:2:end)-1;
        bk = 2*bits(2:2:end)-1;
        dk = ak + 1i*bk;

        % Génération du train de Diracs
        Train_diracs = kron(dk, [1 zeros(1,Ns-1)]);

        % Filtre mise en forme
        h1 = rcosdesign(ALPHA,SPAN,Ns,'sqrt');
        retard = SPAN*Ns/2;
        Xe = filter(h1, 1, [Train_diracs,zeros(1,retard)]);
        Xe = Xe(retard+1:end);

        % Ajout du bruit
        Px2 = mean(abs(Xe).^2);
        sigma2 = Px2*Ns/(2*log2(M)*Eb_N0(i));
        bruit_real2 = sqrt(sigma2)*randn(1,length(real(Xe)));
        bruit_imag2 = sqrt(sigma2)*randn(1,length(imag(Xe)));
        X_bruit2 = Xe + bruit_real2 + 1i*bruit_imag2;
      
        % Filtre receception
        hr = h1;
        Z_bruit2 = filter(hr,1,[X_bruit2 zeros(1,retard)]);
        Z_bruit2 = Z_bruit2(retard+1 : end);

        % Echantillonnage
        Z_ech_bruit2 = Z_bruit2(1:Ns:end);

        % Decision et Demapping
        Z_decide_bruit2 = zeros(1,Nb_bits);
        Z_decide_bruit2(1:2:end) = (sign(real(Z_ech_bruit2))+1)/2;
        Z_decide_bruit2(2:2:end) = (sign(imag(Z_ech_bruit2))+1)/2;

        % TEB
        erreur = sum(abs(Z_decide_bruit2-bits));
        bits_erronnes = bits_erronnes + erreur;
        bits_total = bits_total + Nb_bits;   
    end

    TEB_bruit2(i) = bits_erronnes/bits_total;

    % Les constellations en sortie de liéchantillonneur pour différents Eb/N0.
    scatterplot(Z_ech_bruit2);
    name = strcat("Constellations pour Eb/N_0 = ",num2str(i-1),"dB");
    title(name);
    xlim([-2 2]);
    ylim([-2 2]);
end


%% Vérifier que l’on obtient bien le même TEB que celui obtenu avec la chaine simulée sur fréquence porteuse.
figure("Name","Comparaison des TEBs pour les deux chaines");
semilogy(0:6,TEB_bruit,'--o');
hold on;
semilogy(0:6,TEB_bruit2,'--x');
hold on;
semilogy(0:6,qfunc(sqrt(2*Eb_N0)), '--*');
hold on
title("Taux d'erreur binaire pour les deux chaines");
xlabel("Eb/N0 (en dB)");
ylabel("TEB");
legend("TEB-simule","TEB-simule passe-bas", "TEB-theorique");