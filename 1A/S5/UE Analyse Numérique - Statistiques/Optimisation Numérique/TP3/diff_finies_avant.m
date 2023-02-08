% Auteur : J. Gergaud
% décembre 2017
% -----------------------------
% 



function Jac = diff_finies_avant(fun,x,option)
%
% Cette fonction calcule les différences finies avant sur un schéma
% Paramètres en entrées
% fun : fonction dont on cherche à calculer la matrice jacobienne
%       fonction de IR^n à valeurs dans IR^m
% x   : point où l'on veut calculer la matrice jacobienne
% option : précision du calcul de fun (ndigits)
%
% Paramètre en sortie
% Jac : Matrice jacobienne approximé par les différences finies
%        real(m,n)
% ------------------------------------
I = eye(length(x));
w = max(precision_machine,10^-option);
for k = 1:length(x)
    h=w^0.5*max(abs(x(k)),1);
    Jac(:,k) = (fun(x+h*I(:,k))-fun(x))/h;
end
end

function s = sgn(x)
% fonction signe qui renvoie 1 si x = 0
if x==0
  s = 1;
else 
  s = sign(x);
end
end







