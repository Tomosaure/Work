close all;
clear all;

%% Déclaration des variables
Nb_bits = 12000;
Fp = 2e3;
ALPHA = 0.5;
Fe = 10e3;
Rb = 48e3;
Ns = 4;
SPAN = 4;

%% Comparaison de modulations sur fréquence porteuse

%% Implanter la chaine complète sans bruit

    % Génération des bits
    bits = randi([0,1],1,Nb_bits);

%% La chaine 4-ASK sans bruit
    M_ASK = 4;
    N_ASK = log2(M_ASK);

    % Mapping
    Symboles_4ASK = (2 * bi2de(reshape(bits,N_ASK,length(bits)/N_ASK).')-3).';

    % Train de Diracs
    Suite_diracs_4ASK = kron(Symboles_4ASK, [1 zeros(1,Ns-1)]);

    % Filtre de mise en forme
    h1 = rcosdesign(ALPHA,SPAN,Ns,'sqrt');
    hr = fliplr(h1);
    retard = SPAN * Ns / 2;
    Xe_4ASK = filter(h1, 1, [Suite_diracs_4ASK, zeros(1,retard)]);
    Xe_4ASK = Xe_4ASK(retard+1 : end);

    % Filtre de réception
    Zr_4ASK = filter(hr, 1, [Xe_4ASK zeros(1,retard)]);
    Zr_4ASK = Zr_4ASK(retard+1 : end);

    % Echantillonnage
    Z_ech_4ASK = Zr_4ASK(1:Ns:end);
   
    % Decision et Demapping
    Z_deicide_4ASK = zeros(1,length(Z_ech_4ASK));
    for j=1:length(Z_deicide_4ASK)           
        if Z_ech_4ASK(j) > 2
            Z_deicide_4ASK(j)= 3;
        elseif (Z_ech_4ASK(j) >= 0)
            Z_deicide_4ASK(j) = 1;
        elseif (Z_ech_4ASK(j) < -2)
            Z_deicide_4ASK(j) = -3;
        else
            Z_deicide_4ASK(j) = -1;
        end
    end  
    Z_final_4ASK = reshape(de2bi((Z_deicide_4ASK + 3)/2).',1,length(bits));
   
    % TEB
    TEB_4ASK = sum(abs(Z_final_4ASK-bits));
    fprintf("TEB pour la chaine 4-ASK sans bruit :  %f \n",TEB_4ASK);
   
    % Les constellations en sortie du mapping
    scatterplot(Symboles_4ASK);
    title("Constellation en sortie du mapping : 4ASK");
    xlim([-6 6]);
    ylim([-6 6]);

%% La chaine QPSK sans bruit
    M_QPSK = 4;
    N_QPSK = log2(M_QPSK);
   
    % Mapping
    Symboles_QPSK = bi2de(reshape(bits,length(bits)/N_QPSK, N_QPSK)).';
    X_map_QPSK = pskmod(Symboles_QPSK, M_QPSK, pi/4, 'gray');
   
    % Decision et Demapping
    Z_demap_QPSK = pskdemod(X_map_QPSK, M_QPSK, pi/4, 'gray');
    Z_final_QPSK = de2bi(Z_demap_QPSK.');
    Z_final_QPSK = Z_final_QPSK(:)';
   
    % TEB
    TEB_QPSK = sum(abs(Z_final_QPSK-bits));
    fprintf("TEB pour la chaine QPSK sans bruit :   %f \n",TEB_QPSK);
   
    % Les constellations en sortie du mapping
    scatterplot(X_map_QPSK);
    title("Constellation en sortie du mapping : QPSK");
    xlim([-2 2]);
    ylim([-2 2]) ;
   
%% La chaine 8-PSK sans bruit
    M_8PSK = 8;
    N_8PSK = log2(M_8PSK);
   
    % Mapping
    Symboles_8PSK = bi2de(reshape(bits, length(bits)/N_8PSK, N_8PSK)).';
    X_map_8PSK = pskmod(Symboles_8PSK, M_8PSK, pi/8,'gray');
   
    % Decision et Demapping
    Z_demap_8PSK = pskdemod(X_map_8PSK, M_8PSK, pi/8, 'gray');
    Z_final_8PSK = de2bi(Z_demap_8PSK.');
    Z_final_8PSK = Z_final_8PSK(:)';
   
    % TEB
    TEB_8PSK = sum(abs(Z_final_8PSK-bits));
    fprintf("TEB pour la chaine 8-PSK sans bruit :  %f \n",TEB_8PSK);

    % Les constellations en sortie du mapping
    scatterplot(X_map_8PSK);
    title("Constellation en sortie du mapping : 8PSK");
    xlim([-2 2]);
    ylim([-2 2]);
   
%% La chaine 16-QAM sans bruit
    M_16QAM = 16;
    N_16QAM = log2(M_16QAM);
   
    % Mapping
    Symboles_16QAM = bi2de(reshape(bits, length(bits)/N_16QAM, N_16QAM)).';
    X_map_16QAM = qammod(Symboles_16QAM, M_16QAM, 'gray');
   
    % Decision et Demapping
    Z_demap_16QAM = qamdemod(X_map_16QAM, M_16QAM, 'gray');
    Z_final_16QAM = de2bi(Z_demap_16QAM.');
    Z_final_16QAM = Z_final_16QAM(:)';
   
    % TEB
    TEB_16QAM = sum(abs(Z_final_16QAM-bits));
    fprintf("TEB pour la chaine 16-QAM sans bruit : %f \n",TEB_16QAM);
   
    % Les constellations en sortie du mapping
    scatterplot(X_map_16QAM);
    title("Constellation en sortie du mapping : 16QAM");
    xlim([-5 5]);
    ylim([-5 5]);
   

%% Rajouter le bruit

Eb_N0 = zeros(1,7);

%% 4ASK
TEB_4ASK_bruit = zeros(1,7);

for i = 1:7

    bits_erronnes = 0;
    bits_total = 0;

    while bits_erronnes < 1000

        %% Génération des bits
        bits = randi([0,1],1,Nb_bits);

        %% Mapping
        Symboles_4ASK = (2 * bi2de(reshape(bits,N_ASK,length(bits)/N_ASK).')-3).';

        %% Génération du train de Diracs
        Suite_diracs_4ASK_bruite = kron(Symboles_4ASK, [1 zeros(1,Ns-1)]);
       
        %% Filtre mise en forme
        Xe_4ASK_bruit = filter(h1, 1, [Suite_diracs_4ASK_bruite zeros(1,retard)]);
        Xe_4ASK_bruit = Xe_4ASK_bruit(retard +1 : end);
       
        %% Ajout du bruit
        Eb_N0(i) = 10^((i-1)/10);
        Px_4ASK = mean(abs(Xe_4ASK_bruit).^2);
        sigma_4ASK = (Px_4ASK*Ns)/(2*log2(M_ASK)*Eb_N0(i));
        bruit_real_4ASK = sqrt(sigma_4ASK) * randn(1,length(Xe_4ASK_bruit));
        Xe_4ASK_bruit = Xe_4ASK_bruit + bruit_real_4ASK;
           
        %% Filtre de réception
        Zr_4ASK_bruit = filter(hr, 1, [Xe_4ASK_bruit zeros(1,retard)]);
        Zr_4ASK_bruit = Zr_4ASK_bruit(retard+1 : end);
    
        %% Echantillonnage
        Z_ech_4ASK_bruit =  Zr_4ASK_bruit(1:Ns:end);
       
        %% Decision et Demapping
        Z_dec_4ASK_bruit = zeros(1,length(Z_ech_4ASK_bruit));       
        for j=1:length(Z_dec_4ASK_bruit)           
            if Z_ech_4ASK_bruit(j) > 2
                    Z_dec_4ASK_bruit(j)= 3;
            elseif (Z_ech_4ASK_bruit(j) >= 0)
                Z_dec_4ASK_bruit(j) = 1;
            elseif (Z_ech_4ASK_bruit(j) < -2)
                Z_dec_4ASK_bruit(j) = -3;
            else
                Z_dec_4ASK_bruit(j) = -1;
            end
        end       
        Z_final_4ASK_bruit = reshape(de2bi((Z_dec_4ASK_bruit + 3)/2).',1,Nb_bits);   

        % TEB
        erreur = sum(abs(Z_final_4ASK_bruit-bits));
        bits_erronnes = bits_erronnes + erreur;
        bits_total = bits_total + Nb_bits;  
       
    end
        % TEB
       TEB_4ASK_bruit(i) = bits_erronnes/bits_total;

        % Constellations en sortie de l'échantillonneur
        if (i == 1 || i == 4 || i == 7)
            scatterplot(Z_ech_4ASK_bruit);
            name = strcat("Constellations en sortie d'éch: 4-ASK|Eb/N_0 = ",num2str(i-1),"dB");
            title(name);
            xlim([-6 6]);
            ylim([-6 6]);
        end
end  

%% QPSK
TEB_QPSK_bruit = zeros(1,7);

for i = 1:7

    bits_erronnes = 0;
    bits_total = 0;

    while bits_erronnes < 1000

        %% Génération des bits
        bits = randi([0,1],1,Nb_bits);

        %% Mapping
        Symboles_QPSK = bi2de(reshape(bits,length(bits)/N_QPSK, N_QPSK)).';
        X_map_QPSK = pskmod(Symboles_QPSK, M_QPSK, pi/4, 'gray');

        %% Génération du train de Diracs
        Suite_diracs_QPSK_bruite = kron(X_map_QPSK,    [1 zeros(1,Ns-1)]);
   
        %% Filtre mise en forme
        Xe_QPSK_bruit = filter(h1, 1, [Suite_diracs_QPSK_bruite zeros(1,retard)]);
        Xe_QPSK_bruit = Xe_QPSK_bruit(retard +1 : end);
       
        %% Ajout du bruit
        Eb_N0(i) = 10^((i-1)/10);
        sigma_QPSK = mean(abs(Xe_QPSK_bruit).^2) *   Ns / (2*log2(M_QPSK)  * Eb_N0(i));
        bruit_real_QPSK = sqrt(sigma_QPSK) * randn(1,length(real(Xe_QPSK_bruit)));
        bruit_imag_QPSK = sqrt(sigma_QPSK) * randn(1,length(imag(Xe_QPSK_bruit)));
        Xe_QPSK_bruit = Xe_QPSK_bruit + bruit_real_QPSK + 1i*bruit_imag_QPSK;
           
        %% Filtre de réception
        Zr_QPSK_bruit = filter(hr, 1, [Xe_QPSK_bruit zeros(1,retard)]);
        Zr_QPSK_bruit = Zr_QPSK_bruit(retard+1 : end);
    
        %% Echantillonnage
        Z_ech_QPSK_bruit =  Zr_QPSK_bruit(1:Ns:end);
       
        %% Decision et Demapping     
        Z_demap_QPSK_bruit = pskdemod(Z_ech_QPSK_bruit, M_QPSK, pi/M_QPSK, 'gray');        
        Z_decide_QPSK_bruit = de2bi(Z_demap_QPSK_bruit.');
        Z_decide_QPSK_bruit = Z_decide_QPSK_bruit(:)';

        % TEB
        erreur = sum(abs(Z_decide_QPSK_bruit-bits));
        bits_erronnes = bits_erronnes + erreur;
        bits_total = bits_total + Nb_bits;  
       
    end

        % TEB
        TEB_QPSK_bruit(i) = bits_erronnes/bits_total;
       
        % Constellations en sortie de l'échantillonneur
        if (i == 1 || i == 4 || i == 7)
            scatterplot(Z_ech_QPSK_bruit);
            name = strcat("Constellations en sortie d'éch: QPSK|Eb/N_0 = ",num2str(i-1),"dB");
            title(name);
            xlim([-2 2]);
            ylim([-2 2]);
        end
end  
  
%% 8PSK
TEB_8PSK_bruit = zeros(1,7);

for i = 1:7

    bits_erronnes = 0;
    bits_total = 0;

    while bits_erronnes < 100

        %% Génération des bits
        bits = randi([0,1],1,Nb_bits);

        %% Mapping
        Symboles_8PSK = bi2de(reshape(bits, length(bits)/N_8PSK, N_8PSK)).';
        X_map_8PSK = pskmod(Symboles_8PSK, M_8PSK, pi/8,'gray');

        %% Génération du train de Diracs
        Suite_diracs_8PSK_bruite = kron(X_map_8PSK,    [1 zeros(1,Ns-1)]);
       
        %% Filtre mise en forme
        Xe_8PSK_bruit = filter(h1, 1, [Suite_diracs_8PSK_bruite zeros(1,retard)]);
        Xe_8PSK_bruit = Xe_8PSK_bruit(retard +1 : end);
       
        %% Ajout du bruit
        Eb_N0(i) = 10^((i-1)/10);
        sigma_8PSK = mean(abs(Xe_8PSK_bruit).^2) *   Ns / (2*log2(M_8PSK)  * Eb_N0(i));
        bruit_real_8PSK = sqrt(sigma_8PSK) * randn(1,length(real(Xe_8PSK_bruit)));
        bruit_imag_8PSK = sqrt(sigma_8PSK) * randn(1,length(imag(Xe_8PSK_bruit)));        
        Xe_8PSK_bruit = Xe_8PSK_bruit + bruit_real_8PSK + 1i*bruit_imag_8PSK;

        %% Filtre de réception
        Zr_8PSK_bruit = filter(hr, 1, [Xe_8PSK_bruit zeros(1,retard)]);  
        Zr_8PSK_bruit = Zr_8PSK_bruit(retard+1 : end);         
    
        %% Echantillonnage
        Z_ech_8PSK_bruit =  Zr_8PSK_bruit(1:Ns:end);
       
        %% Decision et Demapping
        Z_demap_8PSK_bruit = pskdemod(Z_ech_8PSK_bruit, M_8PSK, pi/M_8PSK, 'gray');
        Z_final_8PSK_bruit = de2bi(Z_demap_8PSK_bruit.');
        Z_final_8PSK_bruit = Z_final_8PSK_bruit(:)';
            
        % TEB
        erreur = sum(abs(Z_final_8PSK_bruit-bits));
        bits_erronnes = bits_erronnes + erreur;
        bits_total = bits_total + Nb_bits;  
       
    end
        % TEB
        TEB_8PSK_bruit(i) = bits_erronnes/bits_total;
       
        % Constellations en sortie de l'échantillonneur
        if (i == 1 || i == 4 || i == 7)
            scatterplot(Z_ech_8PSK_bruit);
            name = strcat("Constellations en sortie d'éch: 8-PSK|Eb/N_0 = ",num2str(i-1),"dB");
            title(name);
            xlim([-2 2]);
            ylim([-2 2]);
        end
end  

%% 16_QAM

TEB_16QAM_bruit = zeros(1,7);

for i = 1:7

    bits_erronnes = 0;
    bits_total = 0;

    while bits_erronnes < 1000

        %% Génération des bits
        bits = randi([0,1],1,Nb_bits);

        %% Mapping
        Symboles_16QAM = bi2de(reshape(bits, length(bits)/N_16QAM, N_16QAM)).';
        X_map_16QAM = qammod(Symboles_16QAM, M_16QAM, 'gray');

        %% Génération du train de Diracs
        Suite_diracs_16QAM_bruite = kron(X_map_16QAM,  [1 zeros(1,Ns-1)]);
       
        %% Filtre mise en forme
        Xe_16QAM_bruit = filter(h1, 1, [Suite_diracs_16QAM_bruite zeros(1,retard)]);
        Xe_16QAM_bruit = Xe_16QAM_bruit(retard+1 : end);
       
        %% Ajout du bruit
        Eb_N0(i) = 10^((i-1)/10);
        Px_16QAM = mean(abs(Xe_16QAM_bruit).^2);
        sigma_16QAM = (Px_16QAM*Ns)/(2*log2(M_16QAM)*Eb_N0(i));
        bruit_real_16QAM = sqrt(sigma_16QAM) * randn(1,length(real(Xe_16QAM_bruit)));
        bruit_imag_16QAM = sqrt(sigma_16QAM) * randn(1,length(imag(Xe_16QAM_bruit)));
        Xe_16QAM_bruit = Xe_16QAM_bruit + bruit_real_16QAM + 1i*bruit_imag_16QAM;
           
        %% Filtre de réception
        Zr_16QAM_bruit = filter(hr, 1, [Xe_16QAM_bruit zeros(1,retard)]);
        Zr_16QAM_bruit = Zr_16QAM_bruit(retard+1 : end);
    
        %% Echantillonnage
        Z_ech_16QAM_bruit = Zr_16QAM_bruit(1:Ns:end);
       
        %% Decision et Demapping
        Z_demap_16QAM_bruit = qamdemod(Z_ech_16QAM_bruit, M_16QAM, 'gray');
        Z_final_16QAM_bruit = de2bi(Z_demap_16QAM_bruit.');
        Z_final_16QAM_bruit = Z_final_16QAM_bruit(:)';

        % TEB
        erreur = sum(abs(Z_final_16QAM_bruit-bits));
        bits_erronnes = bits_erronnes + erreur;
        bits_total = bits_total + Nb_bits;  
       
    end
        % TEB
        TEB_16QAM_bruit(i) = bits_erronnes/bits_total;
       
        % Constellations en sortie de l'échantillonneur
        if (i == 1 || i == 4 || i == 7)
            scatterplot(Z_ech_16QAM_bruit);
            name = strcat("Constellations en sortie d'éch: 16-QAM|Eb/N_0 = ",num2str(i-1),"dB");
            title(name);
            xlim([-5 5]);         
            ylim([-5 5]);  

        end
end 

%% Affichage des TEB simulés avec TEB théoriques

    % 4ASK
    figure;
    semilogy(0:6,TEB_4ASK_bruit,'--o');
    hold on
    semilogy(0:6,(3/4)*qfunc(sqrt((12/15)*Eb_N0)),'--x');
    hold on
    title("Chaine de 4-ASK avec bruit");
    xlabel("Eb/N0 (dB)");
    ylabel("TEB");
    legend("TEB-simule", "TEB-theorique");

    % QPSK
    figure;
    semilogy(0:6,TEB_QPSK_bruit,'--o');
    hold on
    semilogy(0:6,qfunc(sqrt(2*Eb_N0)),'--x');
    hold on
    title("Chaine de QPSK avec bruit");
    xlabel("Eb/N0 (dB)");
    ylabel("TEB");
    legend("TEB-simule", "TEB-theorique");

    % 8PSK
    figure;
    semilogy(0:6,TEB_8PSK_bruit,'--o');
    hold on
    semilogy(0:6,(2/3)*qfunc(sqrt(2*Eb_N0*sin(pi/M_8PSK))),'--x');
    hold on
    title("Chaine de 8-PSK avec bruit");
    xlabel("Eb/N0 (dB)");
    ylabel("TEB");
    legend("TEB-simule", "TEB-theorique");

    % 16QAM
    figure;
    semilogy(0:6,TEB_16QAM_bruit,'--o');
    hold on
    semilogy(0:6,(3/4)*qfunc(sqrt((12/15)*Eb_N0)),'--x');
    hold on
    title("Chaine de 16-QAM avec bruit");
    xlabel("Eb/N0 (dB)");
    ylabel("TEB");
    legend("TEB-simule", "TEB-theorique");

%% En utilisant les tracés obtenus pour leurs TEBs, comparer et classer les différentes chaines de transmision en en termes d’efficacité en puissance.
% Comparaison de TEBs pour tous les chaines.
figure("Name", "Comparaison de TEBs simules pour tous les chaines");
semilogy(0:6,TEB_4ASK_bruit,'--o');
hold on
semilogy(0:6,TEB_QPSK_bruit,'--*');
hold on
semilogy(0:6,TEB_8PSK_bruit,'--v');
hold on
semilogy(0:6,TEB_16QAM_bruit,'--x');
hold on
title("Comparaison des TEBs simules");
xlabel("Eb/N0 (dB)");
ylabel("TEB");
grid on
legend("4-ASK", "QPSK", "8-PSK", "16-QAM");


%% Pour un même débit binaire, tracer les densités spectrales de puissance des signaux
% Tracer les DSPs des signaux émis

    figure();
    DSP_4ASK_bruit = abs(fft(Xe_4ASK_bruit)).^2;
    abscisse_X4ASK = -Fe/2:Fe/length(DSP_4ASK_bruit):Fe/2-Fe/length(DSP_4ASK_bruit);
    semilogy(abscisse_X4ASK,fftshift(DSP_4ASK_bruit));
    hold on

    DSP_QPSK_bruit = abs(fft(Xe_QPSK_bruit)).^2;
    abscisse_XQPSK = -Fe/2:Fe/length(DSP_QPSK_bruit):Fe/2-Fe/length(DSP_QPSK_bruit);
    semilogy(abscisse_XQPSK,fftshift(DSP_QPSK_bruit));
    hold on

    DSP_8PSK_bruit = abs(fft(Xe_8PSK_bruit)).^2;
    abscisse_X8PSK = -Fe/2:Fe/length(DSP_8PSK_bruit):Fe/2-Fe/length(DSP_8PSK_bruit);
    semilogy(abscisse_X8PSK,fftshift(DSP_8PSK_bruit));
    hold on

    DSP_16QAM_bruit = abs(fft(Xe_16QAM_bruit)).^2;
    abscisse_X16QAM = -Fe/2:Fe/length(DSP_16QAM_bruit):Fe/2-Fe/length(DSP_16QAM_bruit);
    semilogy(abscisse_X16QAM,fftshift(DSP_16QAM_bruit));
    hold on
    
    legend("4-ASK", "QPSK", "8-PSK", "16-QAM");
    title("Tracer des DSPs");
    xlabel("Fréquences en Hz");
    ylabel("DSP");