Fe=24000;           %Nb d'échantillons par seconde
Te=1/Fe;
Rb=3000;
Tb=1/Rb;

%%%%% Q1

% Modulateur 1:
%– Mapping : symboles binaires à moyenne nulle.
% – Filtre de mise en forme : rectangulaire de durée Ts1 = Ns1 Te.

%Génération des bits
nb_bits=100;
Bits1=randi([0,1],1,nb_bits);

%Mapping
Symboles1 = 2*Bits1 - 1;                            % 0 -> -1 ; 1 -> 1

%Suréchantillonage
Rs1 = Rb ;                                         % car M=2^1 avec 1 = nb de bit par symbole et Rs = Rb/log2(M)
Ns1= Fe/Rs1 ;                                      % nb d'échantilons par symboles
Diracs1= kron(Symboles1,[1 zeros(1,Ns1-1)]);

%Filtrage de mise en forme
h1 = ones(1,Ns1);                  % signal rectangle -> que des 1 
D = nb_bits*Tb;                   %durée du signal
t= (0:Fe*D-1)*Te;                 % Fe*D : Temps final = durée du signal * nb d'échantillons 
                                  % Te = intervalle de temps, durée d'un
                                  % échantillon
x1=filter(h1,1,Diracs1);
plot(t,x1);
xlabel('Temps en secondes');
ylabel('Signal transmis après bande de base'); 
figure;

DSP1 = abs(fft(x1).^2);
f1=linspace(-Fe/2,Fe/2,length(DSP1));
semilogy(f1,fftshift(DSP1));                % fftshift centre la courbe en 0
xlabel('Fréquence en Hetz');
ylabel('DSP du signal transmis'); 
figure;

Ts1= 1*Tb;                                            %%Durée symbole 
DSP1_theorique = Ts1*((sinc(f1*Ts1)).^2);             %% ici DSP1_theorique est déjà centré
semilogy(f1,fftshift(DSP1)); 
hold on;
semilogy(f1,fftshift(DSP1_theorique));
hold off;
legend( 'DSP simulé', 'DSP théorique');
xlabel('Fréquence en Hetz');
ylabel('DSP simulée et DSP théorique'); 


% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modulateur 2:
%Mapping : symboles 4-aires à moyenne nulle.
%Filtre de mise en forme : rectangulaire de durée Ts2 = Ns2*Te.

%Génération des bits
Bits2=randi([0,1],1,nb_bits);

%Mapping
LUT=[-3,-1,3,1];
Symb_dec=bit2int(Bits2',2);          %bit2int transforme les bits en nombres, deuxième paramètres : 2 bits par 2 bits  
                                     % ex : 00 = 0, 01 =1, 10 = 2, 11 = 3 
Symboles2=LUT(Symb_dec+1);           % 1 -> -3 , 2 -> -1, 3 -> 3, 4 -> 1


%Suréchantillonage
Rs2 = Rb/2 ;                                        %car M=2^2 avec 2 = nb de bit par symbole et Rs = Rb/log2(M)
Ns2= Fe/Rs2 ;
Diracs2= kron(Symboles2,[1 zeros(1,Ns2-1)]);

%Filtrage de mise en forme
h2=ones(1,Ns2);
x2=filter(h2,1,Diracs2);
plot(t,x2);
xlabel('Temps en secondes');
ylabel('Signal transmis après bande de base'); 

figure;
DSP2 = abs(fft(x2).^2);
f2=linspace(-Fe/2,Fe/2,length(DSP2));
semilogy(f2,fftshift(DSP2));
xlabel('Fréquence en Hetz');
ylabel('DSP du signal transmis'); 

figure;
Ts2= 2*Tb;                                                  %%Durée symbole 
DSP2_theorique = Ts2*((sinc(f2*Ts2)).^2);      
semilogy(f2,fftshift(DSP2)); 
hold on;
semilogy(f2,fftshift(DSP2_theorique));
hold off;
legend( 'DSP simulé', 'DSP théorique');
xlabel('Fréquence en Hetz');
ylabel('DSP simulée et DSP théorique'); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Modulateur 3:
%– Mapping : symboles binaires à moyenne nulle.
% – Filtre de mise en forme : racine de cosinus sur eleve

%Génération des bits
Bits1=randi([0,1],1,nb_bits);

%Mapping
Symboles1 = 2*Bits1 - 1;                                % 0 -> -1 ; 1 -> 1

%Suréchantillonage
Rs1 = Rb ;                                  %car M=2^1 avec 1 = nb de bit par symbole et Rs = Rb/log2(M)
Ns1= Fe/Rs1 ;
Diracs1= kron(Symboles1,[1 zeros(1,Ns1-1)]);


%Filtrage de mise en forme
h3=rcosdesign(0.2, 4, Ns1);
x3=filter(h3,1,Diracs1);
plot(t,x3);
xlabel('Temps en secondes');
ylabel('Signal transmis après bande de base'); 

figure;
DSP3 = abs(fft(x3).^2);
 f3=linspace(-Fe/2,Fe/2,length(DSP3));
semilogy(f3,fftshift(DSP3));
xlabel('Fréquence en Hetz');
ylabel('DSP du signal transmis'); 


figure;
Ts3 = 1*Tb;
Var = mean(abs(Symboles1).^2);
alpha = 0.3;
cond_inf = (1-alpha)/(2*Ts3);
cond_sup = (1+alpha)/(2*Ts3);
S1 = Ts3;
S2 = ((Ts3/2) * (1 + cos((pi*Ts3/alpha) * (abs(f3) - cond_inf))));
DSP3_theorique = (Var/Ts3)*(S1.*(abs(f3) <= cond_inf) + S2.*(abs(f3) >= cond_inf & abs(f3) <= cond_sup)) ;
semilogy(f3,fftshift(DSP3));
hold on;
semilogy(f3,fftshift(DSP3_theorique));
hold off;
legend( 'DSP simulé', 'DSP théorique');
xlabel('Fréquence en Hetz');
ylabel('DSP simulée et DSP théorique'); 

%%%%%%%%% Comparaison efficacité spectrale

semilogy(f1,fftshift(DSP1));
hold on;
semilogy(f2,fftshift(DSP2));
semilogy(f3,fftshift(DSP3));
hold off;
legend( 'DSP du signal pour le modulateur 1', 'DSP du signal pour le modulateur 2', 'DSP du signal pour le modulateur 3');
xlabel('Fréquence en Hetz');
ylabel('DSP simulée des 3 signaux'); 


