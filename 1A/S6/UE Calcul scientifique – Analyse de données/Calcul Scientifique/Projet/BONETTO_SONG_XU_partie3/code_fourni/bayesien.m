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
function indicemax = bayesien(DataA, DataT)
% Calcul de mu et sigma
Mu = zeros(2,size(DataA,1));
for i=1:size(DataA,1)
    [Mu(:,i),Sigma] = estimation_mu_Sigma(DataA(i,:));
end
P_indice = zeros(1,size(DataA,1));
% Calcul des probabilités p(c(x)| w) 
for i=1:size(DataA,1)
    P_indice(i) = gaussienne(DataT, Mu(:,i), Sigma);
end
% Recherche de l'indice du maximum des probabilités
[~,indicemax] = max(P_indice);
end