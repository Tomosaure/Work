clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Separation des canaux RVB','Position',[0,0,0.67*L,0.67*H]);
figure('Name','Nuage de pixels dans le repere RVB','Position',[0.67*L,0,0.33*L,0.45*H]);

% Lecture et affichage d'une image RVB :
I = imread('ishihara-0.png');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:,:,1));
V = double(I(:,:,2));
B = double(I(:,:,3));

% Affichage du canal R :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(R);
axis off;
axis equal;
title('Canal R','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(V);
axis off;
axis equal;
title('Canal V','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(B);
axis off;
axis equal;
title('Canal B','FontSize',20);

% Affichage du nuage de pixels dans le repere RVB :
figure(2);				% Deuxieme fenetre d'affichage
plot3(R,V,B,'b.');
axis equal;
xlabel('R');
ylabel('V');
zlabel('B');
rotate3d;

% Matrice des donnees :
X = [R(:) V(:) B(:)];			% Les trois canaux sont vectorises et concatenes
Xmean = mean(X,1);
Xc = X - Xmean;
% Matrice de variance/covariance :
Sigma = (1/(L*H)) * (transpose(Xc) * Xc);
[W, D] = eig(Sigma);
[D, Isorted] = sort(diag(D),'descend');
W = W(:,Isorted);
C = Xc*W;

C1 = C(:,1);
C2 = C(:,2);
C3 = C(:,3);
C1 = reshape(C1, size(I,1), size(I,2));
C2 = reshape(C2, size(I,1), size(I,2));
C3 = reshape(C3, size(I,1), size(I,2));
C= [C1 C2 C3];

% Matrice de variance/covariance :
Sigma = (1/(L*H)) * (transpose(C) * C);

% Coefficients de correlation lineaire :
Srv = Sigma(1,2)/(sqrt(Sigma(1,1))*sqrt(Sigma(2,2)))
Srb = Sigma(1,3)/(sqrt(Sigma(1,1))*sqrt(Sigma(3,3)))
Sbv = Sigma(2,3)/(sqrt(Sigma(3,3))*sqrt(Sigma(2,2)))

% Proportions de contraste :
Cr = Sigma(1,1)/trace(Sigma)
Cb = Sigma(2,2)/trace(Sigma)
Cv = Sigma(3,3)/trace(Sigma)


I = imread('ishihara-0.png');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(C1);
axis off;
axis equal;
title('C1','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(C2);
axis off;
axis equal;
title('C2','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(C3);
axis off;
axis equal;
title('C3','FontSize',20);

