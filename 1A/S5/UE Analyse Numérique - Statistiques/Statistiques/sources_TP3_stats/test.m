
% TP3 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : XU
% Prenom : Thierry
% Groupe : 1SN-I

function varargout = test(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction estimation_F (exercice_1.m) ------------------------------------
function [rho_F,theta_F,ecart_moyen] = estimation_F(rho,theta)

    A = [cos(theta) sin(theta)];
    B = rho;
    X = A\B;
    rho_F = sqrt(X(1)^2+X(2)^2);
    theta_F = atan2(X(2),X(1));

    % A modifier lors de l'utilisation de l'algorithme RANSAC (exercice 2)
    ecart_moyen = mean(abs(rho - rho_F*cos(theta-theta_F)));

end

% Fonction RANSAC_2 (exercice_2.m) ----------------------------------------
function [rho_F_estime,theta_F_estime] = RANSAC_2(rho,theta,parametres)
    ecart_moyen_meilleur = Inf;
    for i=1:parametres(3)
        Tirage = randperm(length(rho),2);
        [rho_F, theta_F, ~] = estimation_F(rho(Tirage), theta(Tirage));
        a = abs(rho - rho_F*cos(theta-theta_F));
        Donnees_conformes = a < parametres(1);
        if sum(Donnees_conformes)/length(Donnees_conformes) > parametres(2)
            [rho_F,theta_F,ecart_moyen] = estimation_F(rho(Donnees_conformes),theta(Donnees_conformes));
            if ecart_moyen < ecart_moyen_meilleur
                ecart_moyen_meilleur = ecart_moyen;
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
