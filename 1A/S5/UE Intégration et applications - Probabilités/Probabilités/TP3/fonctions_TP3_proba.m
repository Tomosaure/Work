
% TP3 de Probabilites : fonctions a completer et rendre sur Moodle
% Nom : Bonetto
% Prénom : Tom
% Groupe : 1SN-J

function varargout = fonctions_TP3_proba(varargin)

    switch varargin{1}

        case 'matrice_inertie'

            [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

        case {'ensemble_E_recursif','calcul_proba'}

            [varargout{1},varargout{2},varargout{3}] = feval(varargin{1},varargin{2:end});

    end
end

% Fonction ensemble_E_recursif (exercie_1.m) ------------------------------
function [E,contour,G_somme] = ...
    ensemble_E_recursif(E,contour,G_somme,i,j,voisins,G_x,G_y,card_max,cos_alpha)

contour(i,j)=0;
k = 1;
while k <= size(voisins,1) && size(E,1) < card_max
    i_voisin = i+voisins(k,1);
    j_voisin= j+voisins(k,2);
    Gv=[G_x(i_voisin,j_voisin),G_y(i_voisin,j_voisin)];
    if contour(i_voisin,j_voisin) == 1 && (Gv/norm(Gv))*(G_somme'/norm(G_somme))>= cos_alpha
        G_somme = G_somme + Gv;
        [E,contour,G_somme] = ensemble_E_recursif([E; i_voisin j_voisin],contour,G_somme,i_voisin,j_voisin,voisins,G_x,G_y,card_max,cos_alpha);
    end
    k = k + 1;
end
end

% Fonction matrice_inertie (exercice_2.m) ---------------------------------
function [M_inertie,C] = matrice_inertie(E,G_norme_E)
 Elr = fliplr(E);
 C = (G_norme_E'*Elr)/sum(G_norme_E);
 Elr_barre = Elr-C;
 M_inertie = (Elr_barre'*diag(G_norme_E)*Elr_barre)/sum(G_norme_E);
end

% Fonction calcul_proba (exercice_2.m) ------------------------------------
function [x_min,x_max,probabilite] = calcul_proba(E_nouveau_repere,p)
x_min = min(E_nouveau_repere(:,1));
x_max = max(E_nouveau_repere(:,1));
probabilite = 1-binocdf(size(E_nouveau_repere,1),floor((x_max-x_min)*(max(E_nouveau_repere(:,2))-min(E_nouveau_repere(:,2)))),p);
end
