
% TP3 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Bonetto
% Prenom : Tom 
% Groupe : 1SN-J

function varargout = fonctions_TP3_stat(varargin)

   [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction estimation_F (exercice_1.m) ------------------------------------
function [rho_F,theta_F,ecart_moyen] = estimation_F(rho,theta)
    
    A = [cos(theta) sin(theta)];
    B = rho;
    X = A\B;
    rho_F = (X(1).^2+X(2).^2)^0.5;
    theta_F = atan2(X(2),X(1));
    



    % A modifier lors de l'utilisation de l'algorithme RANSAC (exercice 2)
    ecart_moyen = mean(abs(rho - rho_F*cos(theta - theta_F)));

end

% Fonction RANSAC_2 (exercice_2.m) ----------------------------------------
function [rho_F_estime,theta_F_estime] = RANSAC_2(rho,theta,parametres)
    n = length(rho);
    meilleur_ecart_moyen = Inf;
    for k=1:parametres(3)
        idx = randperm(n,2);
        [rho_F , theta_F, ~] = estimation_F(rho(idx),theta(idx));
        d = abs(rho - rho_F*cos(theta-theta_F));
        indice = d < parametres(1);
        if sum(indice)/length(indice) > parametres(2)
            [rho_F , theta_F, ecart_moyen] = estimation_F(rho(indice),theta(indice));
            if ecart_moyen < meilleur_ecart_moyen
                meilleur_ecart_moyen = ecart_moyen;
                rho_F_estime = rho_F;
                theta_F_estime = theta_F;
            end
        end
    end
end

% Fonction G_et_R_moyen (exercice_3.m, bonus, fonction du TP1) ------------
function [G, R_moyen, distances] = ...
         G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)



end

% Fonction estimation_C_et_R (exercice_3.m, bonus, fonction du TP1) -------
function [C_estime,R_estime,critere] = ...
         estimation_C_et_R(x_donnees_bruitees,y_donnees_bruitees,n_tests,C_tests,R_tests)
     
    % Attention : par rapport au TP1, le tirage des C_tests et R_tests est 
    %             considere comme etant deje effectue 
    %             (il doit etre fait au debut de la fonction RANSAC_3)



end

% Fonction RANSAC_3 (exercice_3, bonus) -----------------------------------
function [C_estime,R_estime] = ...
         RANSAC_3(x_donnees_bruitees,y_donnees_bruitees,parametres)
     
    % Attention : il faut faire les tirages de C_tests et R_tests ici



end
