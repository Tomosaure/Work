% BONETTO Tom
% LITSCHGY Antonin

close all;
clear all;
clc;

% Initialisation des variables 
load('donnees1.mat')
load('donnees2.mat')
T = 40e-3;
Fe = 120e3;
Te = 1/Fe;
Ns = T*Fe / length(bits_utilisateur1);
Ts = Ns * Te;
fp1 = 0;
fp2 = 46*10^3;
Ordre = 61;
retard = zeros(1,(Ordre-1)/2);
nb_retard = (Ordre-1)/2;

%% Signaux m1 et m2 et leur DSP

% Génération des signaux m1(t) et m2(t) 
m1 = kron(2*(bits_utilisateur1-0.5), ones(1,Ns));
m2 = kron(2*(bits_utilisateur2-0.5), ones(1,Ns));

% Densité spectrales de puissance des signaux m1(t) et m2(t)
DSP1 = fftshift(abs(fft(m1)).^2);
X1 = -Fe/2:Fe/length(m1):Fe/2-Fe/length(m1);
DSP2 = fftshift(abs(fft(m2)).^2);
X2 = -Fe/2:Fe/length(m1):Fe/2-Fe/length(m1);

% Traçage des figures
subplot(2,2,1);
plot((0:Te:T-Te),m1);
title(['Signal m1'],'interpreter','Latex', 'FontSize',14);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

subplot(2,2,3);
semilogy(X1,DSP1);
title(['DSP Signal m1'],'interpreter','Latex', 'FontSize',14);
xlabel(['f(Hz)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

subplot(2,2,2);
plot((0:Te:T-Te),m2);
title(['Signal m2'],'interpreter','Latex', 'FontSize',14);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

subplot(2,2,4);
semilogy(X2,DSP2);
title(['DSP Signal m2'],'interpreter','Latex', 'FontSize',14);
xlabel(['f(Hz)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

%% Construction du signal MF-TDMA

% Génération du signal 5 slots
Slots1 = [zeros(1,Fe*T), m1, zeros(1,Fe*T*3)];
Slots2 = [zeros(1,Fe*T*4), m2];

% Traçage des signaux résultants
figure();
subplot(2,1,1);
plot(0:Te:T*5-Te,Slots1);
title(['Message NRZ au slot 2'],'interpreter','Latex', 'FontSize',14);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

subplot(2,1,2);
plot(0:Te:T*5-Te,Slots2);
title(['Message NRZ au slot 5'],'interpreter','Latex', 'FontSize',14);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

% Modulation d'amplitude 
mod1 = cos(2*pi*fp1*(0:Te:T*5-Te));
mod2 = cos(2*pi*fp2*(0:Te:T*5-Te));
x1 = Slots1.*mod1;
x2 = Slots2.*mod2;

% Génération du signal MF-TDMA
x = x1+x2;
RSB = 100;
Px = (-1)^2*0.5+(1)^2*0.5;
Pb = Px*10^(-RSB/10);
bruit = sqrt(Pb)*randn(1,length(x));
x = x + bruit;

% Traçage du signal MF-TDMA
figure()
subplot(2,1,1);
plot(0:Te:T*5-Te,x);
title(['signal x(t) = x1(t) + x2(t) bruit\''e'],'interpreter','Latex', 'FontSize',14);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

% Traçage de la DSP du signal MF-TDMA
DSPx = fftshift(abs(fft(x)).^2);
subplot(2,1,2)
semilogy(-Fe/2:Fe/length(x):Fe/2-Fe/length(x),DSPx);
title(['DSP de x(t)'], 'interpreter','Latex', 'FontSize',14);
xlabel(['f(Hz)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

%% Mise en place du récepteur MF-TDMA

% Synthèse du filtre passe-bas
figure()
k = -(Ordre-1)/2:(Ordre-1)/2;
fc = 23*10^3;
nuc = fc/Fe;
hPB = 2*fc/Fe*sinc(2*nuc*k);

% Traçage de la réponse impulsionnelle
subplot(2,1,1);
stem(k*Te,hPB);
title(['R\''eponse impulsionnelle du filtre passe-bas'], 'interpreter','Latex', 'FontSize',14);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

% Traçage de la réponse fréquentielle
subplot(2,1,2)
semilogy(-Fe/2:Fe/length(fft(hPB)):Fe/2-Fe/length(fft(hPB)),fftshift(abs(fft(hPB))))
title(['R\''eponse fr\`equentielle du filtre'], 'interpreter','Latex', 'FontSize',14);
xlabel(['f(Hz)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['log(Amplitude)'], 'interpreter','Latex', 'FontSize',14)

% Traçage de la densité spectrale de puissance du signal MF-TDMA et du
% module de la réponse en fréquences du filtre
figure
semilogy(-Fe/2:Fe/length(x):Fe/2-Fe/length(x),DSPx);
xlabel(['f(Hz)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['log(Amplitude)'], 'interpreter','Latex', 'FontSize',14)
hold on
semilogy(-Fe/2:Fe/length(fft(hPB)):Fe/2-Fe/length(fft(hPB)),fftshift(abs(fft(hPB))))
xlabel(['f(Hz)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['log(abs(Amplitude))'], 'interpreter','Latex', 'FontSize',14)
title(['DSP du signal MF-TDMA et module r\''ponse fr\`equence filtre PB'], 'interpreter','Latex', 'FontSize',14);
legend(['DSP MF-TDMA', 'PB'], 'interpreter','Latex', 'FontSize',14)

% Synthèse du filtre passe-haut  
figure()
dir = dirac(k);
idx = dir == Inf;
dir(idx) = 1;
hPH = dir - hPB;

% Traçage de la réponse impulsionnelle
subplot(2,1,1);
stem(k*Te,hPH);
title(['R\''ponse impulsionnelle du filtre passe-haut'], 'interpreter','Latex', 'FontSize',14);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

% Traçage de la réponse fréquentielle
subplot(2,1,2)
semilogy(-Fe/2:Fe/length(fft(hPH)):Fe/2-Fe/length(fft(hPH)),fftshift(abs(fft(hPH))))
title(['R\''eponse fr\`equentielle du filtre'], 'interpreter','Latex', 'FontSize',14);
xlabel(['f(Hz)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['log(Amplitude)'], 'interpreter','Latex', 'FontSize',14)

% Traçage de la densité spectrale de puissance du signal MF-TDMA et du
% module de la réponse en fréquences du filtre
figure
semilogy(-Fe/2:Fe/length(x):Fe/2-Fe/length(x),DSPx);
xlabel(['f(Hz)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['log(Amplitude)'], 'interpreter','Latex', 'FontSize',14)
hold on
semilogy(-Fe/2:Fe/length(fft(hPH)):Fe/2-Fe/length(fft(hPH)),fftshift(abs(fft(hPH))))
xlabel(['f(Hz)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['log(abs(Amplitude))'], 'interpreter','Latex', 'FontSize',14)
title(['DSP du signal MF-TDMA et module r\''eponse fr\`equence filtre PH'], 'interpreter','Latex', 'FontSize',14);
legend(['DSP MF-TDMA', 'PH'], 'interpreter','Latex', 'FontSize',14)

% Traçage du signal MF-TDMA filtré
xf1 = filter(hPB,1,[x retard]);
xf1 = xf1(1,nb_retard+1:end);
xf2 = filter(hPH,1,[x retard]);
xf2 = xf2(1,nb_retard+1:end);

% Traçage du signal filtré
figure
subplot(2,1,1);
plot(0:Te:T*5-Te,xf1);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)
title(['MF-TDMA apr\`es filtrage PB'], 'interpreter','Latex', 'FontSize',14);

subplot(2,1,2);
plot(0:Te:T*5-Te,xf2);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)
title(['MF-TDMA apr\`es filtrage PH'], 'interpreter','Latex', 'FontSize',14);

%% Retour en bande de base
xf1_bb = xf1;
xf2_bb = filter(hPB,1,[mod2.*xf2 retard]);
xf2_bb = xf2_bb(1,nb_retard+1:end);

figure()
subplot(2,1,1);
plot(0:Te:T*5-Te,xf1_bb);
title(['$\widetilde{x_{1}}$(t) bande de base'], 'interpreter','Latex', 'FontSize',14);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

subplot(2,1,2);
plot(0:Te:T*5-Te,xf2_bb);
titre = title('$\widetilde{x_{2}}$(t) bande de base');
set(titre,'interpreter','Latex','FontSize',14);
xlabel(['t(s)'], 'interpreter','Latex', 'FontSize',14)
ylabel(['Amplitude'], 'interpreter','Latex', 'FontSize',14)

%% Détection du slot utile

% Découpage des slots
X1 = reshape(xf1_bb,T*Fe, 5)';
X2 = reshape(xf2_bb,T*Fe, 5)';

% Calcul de l'énergie
E_X1 = sum(X1.^2,2);
E_X2 = sum(X2.^2,2);

% Recherche du slot d'énergie maximale
[~, IdX1] = max(E_X1);
[~, IdX2] = max(E_X2);

%% Démodulation bande de base

SignalFiltre1= filter(ones(1,Ns),1,X1(IdX1,:)) ;
SignalEchantillonne1=SignalFiltre1(Ns :Ns :end) ;
BitsRecuperes1=(sign(SignalEchantillonne1)+1)/2;
Message_Utilisateur_1 = bin2str(BitsRecuperes1)

SignalFiltre2= filter(ones(1,Ns),1,X2(IdX2,:)) ;
SignalEchantillonne2=SignalFiltre2(Ns :Ns :end) ;
BitsRecuperes2=(sign(SignalEchantillonne2)+1)/2;
Message_Utilisateur_2 = bin2str(BitsRecuperes2)

