clear all; close all;

%% Implémentation chaîne QPSK


%Déclaration des variables

% Fréquence d'échantillonnage
Fe = 10e3;

% Débit binaire et symbole
Rb = 2e3;
M = 4;
Rs = Rb / log2(M);
Ts = 1/Rs;
% Roll-off
alpha = 0.35;

% Fréquence porteuse
fp = 2e3;

% Nombre de bits
Nb_bits = 100;

% Suréchantillonnage
Ns = Fe / Rs;

%% Modulateur

    % Génération des bits
    bits = randi([0,1],1,Nb_bits);

    % Mapping
    ak = 2*bits(1:2:end)-1;
    bk = 2*bits(2:2:end)-1;
    dk = ak + 1i*bk;
    subplot(2,2,1)
    plot(ak,bk,'b*');
    xlim([-2 2]);
    ylim([-2 2]);
    grid on

    % Génération du train de Dirac
    I = kron(ak, [1 zeros(1,Ns-1)]);
    Q = kron(bk, [1 zeros(1,Ns-1)]);

    % Filtre de mise en forme en racine de cosinus surélevé
    span = 8;
    h = rcosdesign(alpha,span,Ns, 'sqrt');   
    retard = span*Ns*0.5;
    I = filter(h,1, [I zeros(1, retard)]);
    Q = filter(h,1, [Q zeros(1, retard)]);
    
    %  Transposition de fréquence 
    t = linspace(0,500*Ts,length(Q));
    x = I.*cos(2*pi*fp*t)-Q.*sin(2*pi*fp*t);

    subplot(2,2,2)
    plot(I)
    subplot(2,2,3)
    plot(Q);
    subplot(2,2,4)
    plot(imag(x));

    % DSP du signal 
    figure
    DSP = fftshift(abs(fft(x)).^2);
    X = -Fe/2:Fe/length(DSP):Fe/2-Fe/length(DSP);
    semilogy(X,DSP);
    xlim([-(1+alpha)*Rs (1+alpha)*Rs])
    
%% Démodulateur

    % Retour en bande de base
    x1 = x.*(2*cos(2*pi*fp*t));
    x2 = x.*(2*sin(2*pi*fp*t));

    h_passe_bas = ones(1,fp);
    x1 = filter(h_passe_bas, 1, x1);
    x2 = filter(h_passe_bas, 1, x2);

    x = x1 -1i*x2;
    figure
    plot(real(x))

    % Filtre de réception (= filtre mise en forme)
    z = filter(h, 1, [x zeros(1, retard)]);
    z = z(retard+1 : end);

    % Diagramme de l'oeil
    figure('Name', "Diagramme de l'oeil");
    plot(reshape(z(Ns+1:end),Ns,length(z(Ns+1:end))/Ns));
    grid on;
    
    % Echantillonnage
    z_echant = z(1 : Ns : end);

    % Détecteur de seuil
    for i = 1 : length(z_echant)
        if (real(z_echant(i)) <= 0 && imag(z_echant(i)) <=     0)
            symboles_decides(i) = -1 - 1i;
       
        elseif (real(z_echant(i)) >= 0 && imag(z_echant(i)) >= 0)
            symboles_decides(i) = 1 + 1i;
       
        elseif (real(z_echant(i)) <= 0 && imag(z_echant(i)) >= 0)
            symboles_decides(i) = -1 + 1i;
       
        elseif (real(z_echant(i)) >= 0 && imag(z_echant(i)) <= 0)
            symboles_decides(i) = 1 - 1i;
        end
    end
    TEB = length(find(symboles_decides - dk)~=0)/length(dk)



