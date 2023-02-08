Fe = 24000;
Te=1/Fe;
Rb = 3000;
Tb = 1/Rb;
nb_bits=10000;
Rs1 = Rb ;                                         
Ns1= Fe/Rs1 ;  

% %%%%%%%%%%%%%%%%%% 5.2.1
% ebN0dB = 0:8;
% Tableau_TEB = zeros(length(ebN0dB),1);
% Tableau_TEB_theo = zeros(length(ebN0dB),1);
% 
% for id = 1 : length(ebN0dB)
%         k=ebN0dB(id);
%         Bits1=randi([0,1],1,nb_bits);
%         Symboles1 = 2*Bits1 - 1;                                                   
%         Diracs1= kron(Symboles1,[1 zeros(1,Ns1-1)]);
%         h1 = ones(1,Ns1);     
%         hr= h1;   
%         x1=filter(h1,1,Diracs1);                               
%            
%         
% 
%         %% Vérification que TEB = 0
% %         n0_1 = 8;
% %         x1r_optimalRetard = x1r(n0_1:Ns1:end);
% %         seuil_1 = 0;
% %         x1r_optimal = (x1r_optimalRetard > seuil_1) ;
% %         TEB1 = sum(abs(Bits1-x1r_optimal))/nb_bits;  
%         %%%
% 
%         Px = mean(abs(x1).^2);
%         M = 2;                                                   %% log2(M) = 1
%         Eb_N0 = 10^(k/10);                                       %%% Eb/N0, qui varie entre 0 et 8 dB donc en linéaire, 10^(const/10), Eb = energie d'un bit, N0 bruit
%         TES=qfunc(sqrt(2*Eb_N0));
%         TEB_theo = TES;                                          %% M = 2 donc log2(M) = 1
%         Tableau_TEB_theo(id,1) = TEB_theo;
%         sigma_n = sqrt((Px*Ns1)/(2*Eb_N0));
%         bruit = sigma_n*randn(1,length(x1));
%         x1 = x1 + bruit;
%         x1r = filter(hr,1,x1); 
% %         figure;
% %         plot(reshape(x1r,2*Ns1,length(x1r)/(2*Ns1)));
%   
% 
% %%%%%%%%%%%%%%%%% 5.2.2
%         n0_1 = 8;
%         x1r_optimalRetard = x1r(n0_1:Ns1:end);
%         seuil_1 = 0;  
%         x1r_optimal = (x1r_optimalRetard > seuil_1); 
%         TEB1 = sum(abs(Bits1-x1r_optimal))/nb_bits;
%         Tableau_TEB(id,1) = TEB1;
%         
% end

% %%%%%%%%%%%%%%%%%% 5.2.3

% figure;
% semilogy(ebN0dB,Tableau_TEB);
% hold on
% semilogy(ebN0dB, Tableau_TEB_theo);
% hold off
% legend( 'TEB de la chaïne de référence', 'TEB théorique');
% xlabel('Eb/N0');
% ylabel('TEB'); 

% 
% 
% 
% %%%%%%%%%%%%%%%%%% 5.3.1
ebN0dB = 0:8;
Tableau_TEB2 = zeros(length(ebN0dB),1);
Tableau_TEB_theo2 = zeros(length(ebN0dB),1);

for id = 1 : length(ebN0dB)

    k=ebN0dB(id);    
    h2 = ones(1,Ns1); 
    Bits2 = randi([0,1],1,nb_bits);
    Symboles2 = 2*Bits2 - 1;                                                   
    Diracs2 = kron(Symboles2,[1 zeros(1,Ns1-1)]);

    %% Modulation
    x2 = filter(h2,1,Diracs2);

%%%%%%%%%%%%%%%%% 5.3.2.1


    Px2 = mean(abs(x2).^2);
    M = 2;                                                   %% log2(M) = 1   
    Eb_N02 = 10^(k/10);                                     
    % le filtrage n'est plus adapté donc on change la formule du TES = TEB
    TEB_theo = qfunc(sqrt(Eb_N02));
    Tableau_TEB_theo2(id,1) = TEB_theo;
    sigma_n2 = sqrt((Px2*Ns1)/(2*Eb_N02));
    bruit2 = sigma_n2*randn(1,length(x2));
    x2 = x2 + bruit2;

    %% Démodulation 
    hr2 = zeros(1,Ns1);
    hr2(1:Ns1/2) = 1; 
    x2r = filter(hr2,1,x2); 

%     figure;
%     plot(reshape(x2r,2*Ns1,length(x2r)/(2*Ns1)));
%     ylabel('Amplitude')
% xlabel('Indice de symbole'); 

%%%%%%%%%%%%%%%%% 5.3.2.2
    n0_2 = 6;
    seuil_2 = 0;
    x2r_optimalRetard = x2r(n0_2:Ns1:end);
    x2r_optimal = (x2r_optimalRetard > seuil_2); 
    TEB2 = sum(abs(Bits2-x2r_optimal))/nb_bits;
    Tableau_TEB2(id,1) = TEB2;

 end
% %%%%%%%%%%%%%%%%% 5.3.2.3
figure;
semilogy(ebN0dB,Tableau_TEB2);
hold on
semilogy(ebN0dB, Tableau_TEB_theo2);
hold off
legend( 'TEB de la chaïne 1', 'TEB théorique');
xlabel('Eb/N0');
ylabel('TEB'); 


% %%%%%%%%%%%%%%%%% 5.3.2.4
figure;
semilogy(ebN0dB,Tableau_TEB);
hold on
semilogy(ebN0dB, Tableau_TEB2);
legend( 'TEB de la chaïne de référence', 'TEB de la chaïne 1');
hold off
xlabel('Eb/N0');
ylabel('TEB'); 

%%% premier TEB plus efficace car courbe en dessous du TEB2, cela est
%%% expliqué par le fait que le filtrage n'est plus adapté
