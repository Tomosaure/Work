% TP1 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Bonetto
% Prénom : Tom
% Groupe : 1SN-J

function varargout = fonctions_TP1_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction G_et_R_moyen (exercice_1.m) ----------------------------------
function [G, R_moyen, distances] = ...
         G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)

    barycentre_X = mean(x_donnees_bruitees);
    barycentre_Y = mean(y_donnees_bruitees);
    G = [barycentre_X, barycentre_Y];
    distances = sqrt(((x_donnees_bruitees-barycentre_X).^2)+((y_donnees_bruitees-barycentre_Y).^2));
    R_moyen = mean(distances);

end

% Fonction estimation_C_uniforme (exercice_1.m) ---------------------------
function [C_estime, R_moyen] = ...
         estimation_C_uniforme(x_donnees_bruitees,y_donnees_bruitees,n_tests)

    [G, R_moyen, ~] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);
    Ctests = G+(rand(n_tests,2)-0.5)*2*R_moyen;
    X = ones(n_tests,1)*x_donnees_bruitees;
    Y = ones(n_tests,1)*y_donnees_bruitees;
    Cx = Ctests(:,1)*ones(1,length(x_donnees_bruitees));
    Cy = Ctests(:,2)*ones(1,length(y_donnees_bruitees));
    M = sqrt(((X-Cx).^2)+((Y-Cy).^2));
    A = sum((M-R_moyen).^2,2);
    [~,indice] = min(A);
    C_estime = [Ctests(indice,1),Ctests(indice,2)];

end

% Fonction estimation_C_et_R_uniforme (exercice_2.m) ----------------------
function [C_estime, R_estime] = ...
         estimation_C_et_R_uniforme(x_donnees_bruitees,y_donnees_bruitees,n_tests)

    [G, R_moyen, ~] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);
    Rtests = R_moyen*(rand(n_tests,1)+0.5);
    Ctests = G+(rand(n_tests,2)-0.5)*2*R_moyen;
    X = ones(n_tests,1)*x_donnees_bruitees;
    Y = ones(n_tests,1)*y_donnees_bruitees;
    Cx = Ctests(:,1)*ones(1,length(x_donnees_bruitees));
    Cy = Ctests(:,2)*ones(1,length(y_donnees_bruitees));
    M = sqrt(((X-Cx).^2)+((Y-Cy).^2));
    A = sum((M-Rtests).^2,2);
    [~,indice] = min(A);
    C_estime = [Ctests(indice,1),Ctests(indice,2)];
    R_estime = Rtests(indice);
end

% Fonction occultation_donnees (donnees_occultees.m) ----------------------
function [x_donnees_bruitees, y_donnees_bruitees] = ...
         occultation_donnees(x_donnees_bruitees, y_donnees_bruitees, theta_donnees_bruitees)
    theta1=2*pi*rand(1);
    theta2=2*pi*rand(1);
    indconserves = theta_donnees_bruitees > theta1 &  theta_donnees_bruitees < theta2;
    indconserves2 = theta_donnees_bruitees > theta1 |  theta_donnees_bruitees < theta2;
    if theta1 < theta2
        x_donnees_bruitees = x_donnees_bruitees(indconserves);
        y_donnees_bruitees = y_donnees_bruitees(indconserves);
    else
        x_donnees_bruitees = x_donnees_bruitees(indconserves2);
        y_donnees_bruitees = y_donnees_bruitees(indconserves2);
    end


end

% Fonction estimation_C_et_R_normale (exercice_4.m, bonus) ----------------
function [C_estime, R_estime] = ...
         estimation_C_et_R_normale(x_donnees_bruitees,y_donnees_bruitees,n_tests)



end
