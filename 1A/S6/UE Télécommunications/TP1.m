% TP1 Télécommunications

clear all; close all;
%% Modulateur en bande de base

% Déclarations des variables 

    % Fréquence d'échantillonnage
    Fe = 24000;
    Te = 1/Fe;

    % Débit binaire par seconde
    Rb = 3000;
    
    % Nombre de bits
    Nb_bits = 24;

%% Modulateur 1
    M = 2;
    Rs = Rb / log2(M);
    Ts = 1 / Rs;
    Ns = Ts / Te;

    % Génération des bits
    bits = randi([0,1],1,Nb_bits);

    % Mapping
    symboles = 2 * bits - 1;

    % Génération du train de Dirac
    train = kron(symboles, [1 zeros(1,Ns-1)]);
    figure
    stem(0:Te:(Nb_bits/Rb)-Te,train);
    
    % Filtrage 
    h = ones(1,Ns);
    modulateur = filter(h,1,train);
    figure
    plot(0:Te:(Nb_bits/Rb)-Te, modulateur);
    figure
    stem(0:Te:(Nb_bits/Rb)-Te, modulateur);
    
    DSP = fftshift(abs(fft(modulateur)).^2);
    X = -Fe/2:Fe/length(modulateur):Fe/2-Fe/length(modulateur);
    figure
    plot(X,DSP);
   % hold on
    f = -Fe/2:10:Fe/2;
    figure
    plot(f,Ts*(sinc(pi*f*(Ts/2))).^2);
    title(['Signal m1'],'interpreter','Latex', 'FontSize',14);
    xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
    ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

%% Modulateur 2
    M = 4;
    Rs = Rb / log2(M);
    Ts = 1 / Rs;
    Ns = Ts / Te;

    % Génération des bits
    bits = randi([0,1],1,Nb_bits);

    % Mapping
    bit_ints = bit2int(bits',2);
    LUT = [-3 -1 1 3];
    symboles = LUT(bit_ints+1);

    % Génération du train de Dirac
    train = kron(symboles, [1 zeros(1,Ns-1)]);
    figure
    stem(0:Te:(Nb_bits/Rb)-Te,train);
    
    % Filtrage 
    h = ones(1,Ns);
    modulateur = filter(h,1,train);
    figure
    plot(0:Te:(Nb_bits/Rb)-Te, modulateur);
    figure
    stem(0:Te:(Nb_bits/Rb)-Te, modulateur);
    figure
    pwelch(modulateur,[],[],[],Fe,'twosided')

%% Modulateur 3
    M = 2;
    Rs = Rb / log2(M);
    Ts = 1 / Rs;
    Ns = Ts / Te;
    L = 4;
    alpha = 0.5;
    % Génération des bits
    bits = randi([0,1],1,Nb_bits);

    % Mapping
    symboles = 2 * bits - 1;

    % Génération du train de Dirac
    train = kron(symboles, [1 zeros(1,Ns-1)]);
    figure
    stem(0:Te:(Nb_bits/Rb)-Te,train);

    % Filtrage
    h = rcosdesign(alpha,L,Ns);
    modulateur = filter(h,1,train);
    figure
    plot(0:Te:(Nb_bits/Rb)-Te, modulateur);
    figure
    stem(0:Te:(Nb_bits/Rb)-Te, modulateur);
    figure
    pwelch(modulateur,[],[],[],Fe,'twosided')
    


%% Etude des interférences entre symbole et du critère de Nyquist

