%% Etude de l'impact du bruit, filtrage adapté, taux d'erreur binaire, efficacité en puissance

clear all; close all;

% Déclarations des variables 

    % Fréquence d'échantillonnage
    Fe = 24000;
    Te = 1/Fe;


    % Débit binaire par seconde
    Rb = 3000;

    % Nombre de bits
    Nb_bits = 100;

    M = 2;
    Rs = Rb / log2(M);
    Ts = 1 / Rs;
    Ns = Ts / Te;

%% Introduction du bruit

    % Taux d'erreur binaire en fonction du rapport signal bruit par bit à
    % l'entrée du récepteur
    TEB_1 = zeros(1,8);
    for Eb_N0_dB = 0 : 8

        bits_erronnes = 0;
        bits_total = 0;
        
        while bits_erronnes < 1000

            %% Modulateur
    
            % Génération des bits
            bits = randi([0,1],1,Nb_bits);
    
            % Mapping
            symboles = 2 * bits - 1;
    
            % Génération du train de Dirac
            train = kron(symboles, [1 zeros(1,Ns-1)]);
        
            % Filtrage 
            h = ones(1,Ns);
            modulateur = filter(h,1,train);
            
            % Calcul du bruit
            Px = mean(abs(modulateur).^2);
            sigma2 = (Px*Ns)/(2*log2(M)*(10^(Eb_N0_dB/10)));
            bruit = sqrt(sigma2)*randn(1,length(modulateur));
    
            % Ajout du bruit
            y = modulateur + bruit;
            
            % Filtre de réception
            z = filter(h, 1, y);
    
            % Diagramme de l'oeil
            %subplot(3,3,Eb_N0_dB+1)
            %plot(1:2*Ns,reshape(z,2*Ns,length(z)/(2*Ns)));

            % Echantillonnage
            n0 = 8;
            z_echant = z(n0: Ns : end);
    
            % Détecteur de seuil
            z_seuil = sign(z_echant);
    
            % Demapping
            z_demap = (z_seuil+1) / 2;
           
            % TEB
            erreur = sum(abs(z_demap-bits));
            bits_erronnes = bits_erronnes + erreur;
            bits_total = bits_total + Nb_bits;
        end

        TEB_1(Eb_N0_dB+1) = bits_erronnes/bits_total;
    end


    %% Deuxième chaine à étudier, implanter et comparer à la chaine de référence

    %% Modulateur

    % Génération des bits
    bits = randi([0,1],1,Nb_bits);

    % Mapping
    symboles = (2 * bi2de(reshape(bits, 2, length(bits)/2).') - 3).';

    % Génération du train de Dirac
    train = kron(symboles, [1 zeros(1,Ns-1)]);
    
    % Filtrage 
    h = ones(1,Ns);
    modulateur = filter(h,1,train);

    %% Démodulateur
    
    % Filtre de réception
    z = filter(h,1, modulateur);

    % Diagramme de l'oeil
    figure
    plot(1:2*Ns,reshape(z,2*Ns,length(z)/(2*Ns)));
    grid on
    title('Deuxième chaine');
    
    % Echantillonnage
    n0=8;
    z_echant = z(n0 : Ns : end);

    % Détecteur de seuil
    z_seuil = zeros(1,length(z_echant));

    for i = 1:length(z_echant)
        if z_echant(i) >= 2*Ns
            z_seuil(i) = 3;
        elseif z_echant(i) >= 0
            z_seuil(i) = 1;
        elseif z_echant(i) < -2*Ns
            z_seuil(i) = -3;
        else
            z_seuil(i) = -1;
        end
    end

    % Demapping
    z_demap = reshape(de2bi((z_seuil + 3)/2).', 1, length(bits));

    % TEB
    %erreur = sum(abs(z_demap-bits))
    TEB = sum(abs(z_demap-bits))

    %% Introduction du bruit

    % Taux d'erreur binaire en fonction du rapport signal bruit par bit à
    % l'entrée du récepteur
    TES = zeros(1,8);
    TEB = zeros(1,8);
    M = 4;
    for Eb_N0_dB = 0 : 8

        bits_erronnes = 0;
        bits_total = 0;

        symboles_erronnes = 0;
        symboles_total = 0;
        
        while bits_erronnes < 1000

            %% Modulateur
        
            % Génération des bits
            bits = randi([0,1],1,Nb_bits);
        
            % Mapping
            symboles = (2 * bi2de(reshape(bits, 2, length(bits)/2).') - 3).';
        
            % Génération du train de Dirac
            train = kron(symboles, [1 zeros(1,Ns-1)]);
            
            % Filtrage 
            h = ones(1,Ns);
            modulateur = filter(h,1,train);

            % Calcul du bruit
            Px = mean(abs(modulateur).^2);
            sigma2 = (Px*Ns)/(2*log2(M)*(10^(Eb_N0_dB/10)));
            bruit = sqrt(sigma2)*randn(1,length(modulateur));
    
            % Ajout du bruit
            y = modulateur + bruit;

            %% Démodulateur
            
            % Filtre de réception
            z = filter(h, 1, y);
        
            % Diagramme de l'oeil
%             figure
%             plot(1:2*Ns,reshape(z,2*Ns,length(z)/(2*Ns)));
%             grid on
%             title('Deuxième chaine');
            
            % Echantillonnage
            n0 = 8;
            z_echant = z(n0 : Ns : end);
        
            % Détecteur de seuil
            z_seuil = zeros(1,length(z_echant));
        
            for i = 1:length(z_echant)
                if z_echant(i) >= 2*Ns
                    z_seuil(i) = 3;
                elseif z_echant(i) >= 0
                    z_seuil(i) = 1;
                elseif z_echant(i) < -2*Ns
                    z_seuil(i) = -3;
                else
                    z_seuil(i) = -1;
                end
            end
        
            % Demapping
            z_demap = reshape(de2bi((z_seuil + 3)/2).', 1, length(bits));
        
            % TEB
            erreur_bits = sum(abs(z_demap-bits));
            bits_erronnes = bits_erronnes + erreur_bits;
            bits_total = bits_total + length(bits);

            %TES
            erreur_symbole = sum(abs(z_seuil-symboles));
            symboles_erronnes = symboles_erronnes + erreur_symbole;
            symboles_total = symboles_total + length(symboles);
            
        end

        %TES(Eb_N0_dB+1) = (length(find(z_seuil ~= symboles)) / length(symboles));
        TES(Eb_N0_dB+1) = (symboles_erronnes/symboles_total);
        %TEB(Eb_N0_dB+1) = (length(find(z_demap ~= bits)) / length(bits));
        TEB(Eb_N0_dB+1) = (bits_erronnes/bits_total);
        %TEB=TES/2;
    end

    Eb_N0_dB = [0:8];

    figure
    semilogy(Eb_N0_dB, TES, '--o');
    hold on
    TESTh = (3/2)*qfunc(sqrt((4/5)*(10.^(Eb_N0_dB/10))));
    semilogy(Eb_N0_dB ,TESTh, '--o');  
    xlabel("Indice de symbole")
    ylabel("TES")
    legend('TES estimé', 'TES théorique')
    
    figure
    semilogy(Eb_N0_dB ,TEB, '--o');
    hold on
    TEBTh = (3/4)*qfunc(sqrt((4/5)*(10.^(Eb_N0_dB/10))));
    semilogy(Eb_N0_dB ,TEBTh, '--o');
    xlabel("Eb/N0 (en dB)")
    ylabel("TEB")
    legend('TEB estimé', 'TEB théorique')

    figure
    semilogy(Eb_N0_dB ,TEB, '--o');
    hold on
    semilogy(Eb_N0_dB ,TEB_1, '--o');
    xlabel("Eb/N0 (en dB)")
    ylabel("TEB")
    legend('TEB simulé', 'TEB de référence')
