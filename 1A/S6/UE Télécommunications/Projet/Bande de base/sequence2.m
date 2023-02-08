Fe=24000;
Te=1/Fe;
Rb=3000;
Tb=1/Rb;

%%%%% 4.2


%%%%%%%%%%%%%%%%%%% Q1

% Modulateur 1:
%– Mapping : symboles binaires `a moyenne nulle.
% – Filtre de mise en forme : rectangulaire de dur ́ee Ts1 = Ns1 Te.


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
h1 = ones(1,Ns1);                 % signal rectangle / porte -> que des 1 
D = nb_bits*Tb;                   %durée du signal
t= (0:Fe*D-1)*Te;                 % Fe*D : Temps final = durée du signal * nb d'échantillons 
                                  % Te = intervalle de temps, durée d'un
                                  % échantillon

x1=filter(h1,1,Diracs1);          % filtrage par un signal porte h1




%%%%%%%%%%%%%%%%%%% Q2

% Tracé du signal en sortie du filtre de réception,  moyenne d'un symbole

hr= h1;                                            % hr = ones(1,Ns1);   filtre de mise en forme et filtre de réception
                                                   % de même réponse impulsionnelle rectangulaire de durée Ts.

x1r = filter(h1,1,x1);                             % filtrage par un signal porte hr
% plot(t,x1r);
% xlabel('Temps en secondes');
% ylabel('Signal en sortie du filtre de reception'); 




%%%%%%%%%%%%%%%%%%% Q3


% figure;
g = conv (h1,hr);  %%%%% réponse impulsionnelle totale, on "additionne" les deux réponses impulsionnelles : de réception et de mise en forme

% t_g = (0:length(g)-1)*Te;
% plot(t_g,g);                                %%% échelle de temps en abscisses : numéro de l'échantillon * Te 
% xlabel('Temps en secondes');
                                           %%% échantillon 1 : 0,
                                            %%% échantillon 2 : Te secondes
                                            %%% échantillon 3 : Te*2 secondes
% plot(g);                                            
% ylabel('Amplitude');  
%%%%%%%%%%%%%%%%%%% Q4
% sur la pointe, là où il y a le plus de puissance 
% n0 = 8
%%%%%%%%%%%%%%%%%%% Q5
% figure;
% plot(reshape(x1r,2*Ns1,length(x1r)/(2*Ns1)));               %% sur deux échantillons par symboles
% ylabel('Amplitude')
% xlabel('Indice de symbole');  

%%%%%%%%%%%%%%%%%%% Q6

% là où il n'y a que deux valeurs possible, où les deux valeurs sont le plus écartés = pas d'interférences  
% On met le seuil au milieu (ici seuil = 0), lorsqu'on ajoute du bruit, il y a peu de
% chance qu'on se trompe de valeur/ symbole
% La question 4 donne une valeur approximative alors que le diagramme de
% l'oeil est plus précise mais donne le n0 en modulo Ns

%le diragramme de l'oeil représente la superposition de tout les pics
%possible du signal
% ici n0 = 8

%%%%%%%%%%%%%%%%%%% Q7
n0_1 = 8;
x1r_optimalRetard = x1r(n0_1:Ns1:end);
seuil_1 = 0;  
x1r_optimal = (x1r_optimalRetard > seuil_1); 
TEB1 = sum(abs(Bits1-x1r_optimal))/nb_bits;    %TEB = nb bits éronnés / nb_bits

%%%%%%%%%%%%%%%%%%% Q8
n0_2 = 3;
x1r_nonOptimal = x1r(n0_2:Ns1:end);
seuil_1 = 0;  
x1r_optimal = (x1r_nonOptimal > seuil_1); 
TEB2 = sum(abs(Bits1-x1r_optimal))/nb_bits;    %TEB = nb bits éronnés / nb_bits

% Le taux d'erreur binaire est non nul, en effet pour n0 = 3, il y a 5
% valeurs possible d'après le diagramme de l'oeil 





%%%%% 4.3


%%%%%%%%%%%%%%%%%%% Q1
% figure;
% BW = 8000;     %%fréquence de coupure
% N = 61;   %%ordre
% hc = (2*BW/Fe)*sinc(2*(BW/Fe)*[(-N-1)/2 : (N-1)/2]);
% 
% 
% g2 = conv (g,hc);  %%%%% réponse impulsionnelle totale, on "additionne" les trois réponses impulsionnelles : de réception, de mise en forme 
% % plot(g2);
% % ylabel('Amplitude')
% %  xlabel('Indice de symbole');      
% 
% figure;
% x1r_2 = filter(hc,1,x1r);  %%sortie du filtre de réception
% % plot(reshape(x1r_2,2*Ns1,length(x1r_2)/(2*Ns1))); 
% %  ylabel('Amplitude')
% %  xlabel('Indice de symbole');  
% 
% 
% figure;
% G = fft(g);
% Hc = fft(hc);
% f1=linspace(-Fe/2,Fe/2,length(G));
% f2=linspace(-Fe/2,Fe/2,length(Hc));
% % semilogy(f1,fftshift(abs(G)));
% % hold on;
% % semilogy(f2,fftshift(abs(Hc)));    
% % hold off;
% % ylabel('Réponse en fréquence de G et de Hc')
% % xlabel('Fréquence en Hz');  
% 
% 
% n0_3 = 39;
% x1r_nonOptimal2 = x1r_2(n0_3:Ns1:end);
% seuil_1 = 0;  
% x1r_optimal2 = (x1r_nonOptimal2 > seuil_1); 
% x1r_optimal2 = [x1r_optimal2  0 0 0  0];
% TEB3 = sum(abs(Bits1-x1r_optimal2))/nb_bits;    %TEB = nb bits éronnés / nb_bits


%%%%%%%%%%%%%%%%%%% Q2
figure;
BW2 = 1000;     %%fréquence de coupure
hc2 = (2*BW2/Fe)*sinc(2*(BW2/Fe)*[(-N-1)/2 : (N-1)/2]);


g3 = conv (g,hc2);  %%%%% réponse impulsionnelle totale, on "additionne" les trois réponses impulsionnelles : de réception, de mise en forme 
plot(g3);
ylabel('Amplitude')
xlabel('Indice de symbole');      

figure;
x1r_3 = filter(hc2,1,x1r);  %%sortie du filtre de réception
plot(reshape(x1r_3,2*Ns1,length(x1r_3)/(2*Ns1))); 
ylabel('Amplitude')
xlabel('Indice de symbole');  


figure;
G2 = fft(g3);
Hc2 = fft(hc2);
f1=linspace(-Fe/2,Fe/2,length(G2));
f22=linspace(-Fe/2,Fe/2,length(Hc2));
semilogy(f1,fftshift(abs(G2)));
hold on;
semilogy(f22,fftshift(abs(Hc2)));    
hold off;
ylabel('Réponse en fréquence de G et de Hc')
xlabel('Fréquence en Hz');  

n0_4 = 49;
x1r_nonOptimal3 = x1r_3(n0_4:Ns1:end);
x1r_optimal3 = (x1r_nonOptimal3 > seuil_1); 
x1r_optimal3 = [x1r_optimal3  0 0 0 0 0 0];
TEB4 = sum(abs(Bits1-x1r_optimal3))/nb_bits;    












