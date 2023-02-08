clear all;
format long;

%%%%%%%%%%%%
% PARAMÈTRES
%%%%%%%%%%%%

% taille de la matrice symétrique
n = 200;

% type de la matrice (voir matgen_csad)
% imat == 1 valeurs propres D(i) = i
% imat == 2 valeurs propres D(i) = random(1/cond, 1) avec leur logarithmes
%                                  uniformément répartie, cond = 1e10
% imat == 3 valeurs propres D(i) = cond**(-(i-1)/(n-1)) avec cond = 1e5
% imat == 4 valeurs propres D(i) = 1 - ((i-1)/(n-1))*(1 - 1/cond) avec cond = 1e2
imat = 1;

% tolérance
eps = 1e-8;
% nombre d'itérations max pour atteindre la convergence
maxit = 10000;

% méthode de calcul
v = 2; % subspace iteration v2

% taille du sous-espace (V1, v2, v3)
m = 70;

% pourcentage de la trace que l'on veut atteindre (v1, v2, v3)
percentage = 0.5;
p = 1;
genere = 0;
[W, V, flag] = eigen_2022(imat, n, v, m, eps, maxit, percentage, p, genere);
