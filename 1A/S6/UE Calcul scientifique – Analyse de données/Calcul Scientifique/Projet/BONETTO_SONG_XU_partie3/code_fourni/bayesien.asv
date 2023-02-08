%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
%
% Données :
% DataA      : les données d'apprentissage (connues)
%
% DataT      : les données de test
%
% K          : le K de l'algorithme des k-plus-proches-voisins
% ListeClass : les classes possibles (== les labels possibles)
%
% Résultat :
% indicemax  : indice de la probabiblité la plus grande
%--------------------------------------------------------------------------
function indicemax = bayesien(DataA)
% Calcul de mu et sigma
[Mu,Sigma] = estimation_mu_Sigma(DataA);

% Calcul des probabilités p(c(x)| w) 
P = gaussienne(DataA, Mu, Sigma);

% Recherche de l'indice du maximum des probabilités
[~,indicemax] = max(P);

end

