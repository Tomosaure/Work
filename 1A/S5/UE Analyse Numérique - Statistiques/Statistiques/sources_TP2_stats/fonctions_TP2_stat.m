
% TP2 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Bonetto
% Prénom : Tom
% Groupe : 1SN-J

function varargout = fonctions_TP2_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction centrage_des_donnees (exercice_1.m) ----------------------------
function [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = ...
                centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees)     
    x_G= mean(x_donnees_bruitees);
    y_G = mean(y_donnees_bruitees);
    x_donnees_bruitees_centrees = x_donnees_bruitees - x_G;
    y_donnees_bruitees_centrees = y_donnees_bruitees - y_G;
    
     
end

% Fonction estimation_Dyx_MV (exercice_1.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
           estimation_Dyx_MV(x_donnees_bruitees,y_donnees_bruitees,n_tests)

[x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = ...
                centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);


phitest = pi*rand(n_tests,1)-pi/2;
Y = ones(n_tests,1)*y_donnees_bruitees_centrees;
tanphiX = tan(phitest)*x_donnees_bruitees_centrees;
M = Y-tanphiX;
N = M.^2;
A = sum(N,2);
[~, indice] = min(A);
phimin = phitest(indice);
a_Dyx = tan(phimin);
b_Dyx = y_G-a_Dyx*x_G;
end

% Fonction estimation_Dyx_MC (exercice_2.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
                   estimation_Dyx_MC(x_donnees_bruitees,y_donnees_bruitees)

A = [ x_donnees_bruitees' ones(length(x_donnees_bruitees),1)];
B = y_donnees_bruitees';
X = A\B;
a_Dyx = X(1);
b_Dyx = X(2);
end

% Fonction estimation_Dorth_MV (exercice_3.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
         estimation_Dorth_MV(x_donnees_bruitees,y_donnees_bruitees,n_tests)

[x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = ...
                centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);

thetatest = pi*rand(n_tests,1)-pi/2;
Y = sin(thetatest)*y_donnees_bruitees_centrees;
X = cos(thetatest)*x_donnees_bruitees_centrees;
M = X+Y;
N = M.^2;
A = sum(N,2);
[~, indice] = min(A);
theta_Dorth = thetatest(indice);
rho_Dorth = x_G*cos(theta_Dorth)+y_G*sin(theta_Dorth);


end

% Fonction estimation_Dorth_MC (exercice_4.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
estimation_Dorth_MC(x_donnees_bruitees,y_donnees_bruitees)

[x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = ...
                centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees); 

C = [x_donnees_bruitees_centrees' y_donnees_bruitees_centrees'];
A = C'*C;
[vecteurs_propres, valeurs_propres] = eig(A);
[~, indice] = min(diag(valeurs_propres));
Y = vecteurs_propres(:,indice);
theta_Dorth = atan(Y(2)/Y(1));
rho_Dorth = x_G*cos(theta_Dorth)+y_G*sin(theta_Dorth);

end
