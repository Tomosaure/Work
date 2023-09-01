clear all;
close all;

% Obtenir la taille de l'écran
taille_ecran = get(0, 'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Créer une nouvelle figure pour l'affichage
figure('Name', 'Decomposition structure + texture par analyse SVD', 'Position', [0, 0, L, 0.5*H]);

% Charger l'image
I = imread('Images\kim.jpg');
m = im2double(I);

% Paramètre de décomposition
k = 40;

% Afficher l'image d'origine
subplot(1, 3, 1);
imshow(I);

% Calculer la structure de l'image avec la SVD
if size(m,3) == 3
    structure = m;
    for i = 1:3
        structure(:,:,i) = decomposeSVD(m(:,:,i),k);
    end
else
    structure = decomposeSVD(m,k);
end

imwrite(structure,'pilier_compress.jpg')

% Calculer la texture en soustrayant la structure de l'image d'origine
texture = m - structure;

% Afficher la structure
subplot(1, 3, 2);
imshow(structure);
title(['k = ',num2str(k)], "FontSize",14);

% Afficher la texture
subplot(1, 3, 3);
imshow(texture);

figure('Name','Différentes proportions de texture');
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

function structure = decomposeSVD(image,k)
    % Effectuer la décomposition SVD de l'image
    [U, S, V] = svd(image);
    V = V';
    
    % Tronquer les matrices U, S et V pour la décomposition
    U(:, k:end) = [];
    S(k:end, :) = [];
    S(:, k:end) = [];
    V(k:end, :) = [];
        
    % Reconstruire l'image à partir des matrices tronquées
    structure = U * S * V;
end
