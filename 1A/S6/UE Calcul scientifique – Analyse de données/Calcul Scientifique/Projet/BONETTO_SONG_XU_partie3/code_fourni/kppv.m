
%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%
% Données :
% DataA      : les données d'apprentissage (connues)
% LabelA     : les labels des données d'apprentissage
%
% DataT      : les données de test (on veut trouver leur label)
% Nt_test    : nombre de données tests qu'on veut labelliser
%
% K          : le K de l'algorithme des k-plus-proches-voisins
% ListeClass : les classes possibles (== les labels possibles)
%
% Résultat :
% Partition : pour les Nt_test données de test, le label calculé
%
%--------------------------------------------------------------------------
function [Partition] = kppv(DataA, LabelA, DataT, Nt_test, K, ListeClass)

[Na,~] = size(DataA);

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);

disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])
    
    % Calcul des distances entre le vecteur de test 
    % et les vecteurs d'apprentissage (voisins)
    Distance_vecteurs = sqrt(sum((repmat(DataT(i,:),Na,1)-DataA).^2,2));
    
    % On ne garde que les indices des K + proches voisins
    [~, Donnees_triees] = sort(Distance_vecteurs);

    Donnees_triees = Donnees_triees(1:K);
    
    % Comptage du nombre de voisins appartenant à chaque classe
    label_garde = LabelA(Donnees_triees);
    Nb_classes = ones(length(ListeClass), 1);

    for j = 1:length(ListeClass)
        nombre = length(find(label_garde==ListeClass(j)));
        Nb_classes(j,1) = nombre;
    end
    
    
    % Recherche des classes contenant le maximum de voisins
    [m, indices_max] = max(Nb_classes);
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs  
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    if length(m) == 1
        Classe = label_garde(1);
    else
        Classe = indices_max-1;
    end
    

    
    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    Partition(i,1) = Classe;
    
    
end
