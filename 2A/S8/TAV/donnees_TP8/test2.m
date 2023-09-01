clear all;
close all;

% Obtenir la taille de l'écran
taille_ecran = get(0, 'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Créer une nouvelle figure pour l'affichage
figure('Name', 'Decomposition structure + texture par analyse SVD', 'Position', [0, 0, L, 0.5*H]);

% Charger l'image
I = imread('Images\lena.jpg');
m = im2double(I);

% Convertir l'image en niveaux de gris si elle est en couleur


% Paramètre de décomposition
k = 10; 

% Afficher l'image d'origine
subplot(1, 3, 1);
imshow(I);
title('Image d''origine');

red = dec(m(:,:,1),k);
red2 = dec(m(:,:,2),k);
red3 = dec(m(:,:,3),k);
g=m;
g(:,:,1)=red;
g(:,:,2)=red2;
g(:,:,3)=red3;

structure = g;

% Afficher la structure
subplot(1, 3, 2);
imshow(g);
title('Structure');

% Afficher la texture
subplot(1, 3, 3);
imshow(m-g);
title('Texture');
texture = m-g;
figure;
for i = -2:3   
    enhancedImage = structure + i.*texture;
    subplot(2, 3, i+3);
    imshow(enhancedImage);
    title(['Image ', num2str(i+3)]);
end

figure;
for i = -1:4
    enhancedImage = (0.5*i).*structure + texture;
    subplot(2, 3, i+2);
    imshow(enhancedImage);
    title(['Image ', num2str(i+2)]);
end

% Effectuer la décomposition SVD de l'image
function im = dec(img,k)
[U, S, V] = svd(img);
V = V';

% Tronquer les matrices U, S et V pour la décomposition
U(:, k:end) = [];
S(k:end, :) = [];
S(:, k:end) = [];
V(k:end, :) = [];
    
% Reconstruire l'image à partir des matrices tronquées
im = U * S * V;

% Calculer la texture en soustrayant la structure de l'image d'origine
end

