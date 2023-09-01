clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Charger l'image
m = imread('pears.png');

[nb_lignes,nb_colonnes,nb_canaux] = size(m);
if nb_canaux==3
	m = rgb2gray(m);
end

% Afficher l'image d'origine
figure('Name','Segmentation par contour actif','Position',[0.1*L,0.1*H,0.9*L,0.7*H]);
imshow(m);
title('Image d''origine')
pause(2);

% Demander à l'utilisateur de sélectionner un rectangle sur l'image
rect = getrect;

% Convertir les coordonnées du rectangle en entiers
rect = round(rect);

% Extraire la région sélectionnée de l'image
roi = imcrop(m, rect);

k = 2;
itermax = 1000;

% Appeler la fonction kmoyenne uniquement sur la ROI
[centers, labels] = kmoyenne(roi, k, itermax);

% Remplacer les valeurs des étiquettes de cluster par les valeurs des centres correspondants
roiRows = size(roi, 1);
roiCols = size(roi, 2);

% Associer les couleurs aux centres
for i = 1:3
    centers(1, i) = 0;
    centers(2, i) = 255;
end

% Associer la couleur des pixels
for i = 1:roiRows
    for j = 1:roiCols
        roi(i, j) = centers(labels(i, j), 3);
    end
end

figure;
subplot(1,2,1);
imshow(roi);
title('Segmentation');

roi = imfill(roi);

subplot(1,2,2);
imshow(roi);
title('Amélioration');

flag = 0;
for i = round(roiRows/2):roiRows
    for j = round(roiCols/2):roiCols-1
        % Quand on se trouve à la forntière, la valeur change
        if roi(i,j) ~= roi(i,j+1)
            flag = 1;
            break
        end
    end
    if flag
        break
    end
end

pixel_contour = [i,j];
% Appliquer la détection des contours avec bwtraceboundary
roiEdges = bwtraceboundary(roi, pixel_contour, 'W',8,Inf,'counterclockwise');

% Afficher l'image d'origine avec les contours superposés
% Superposer les contours sur l'image d'origine
figure;
imshow(m);
hold on;
plot(roiEdges(:, 2) + rect(1), roiEdges(:, 1) + rect(2), 'r', 'LineWidth', 2);
title('Image d''origine avec les contours en rouge');
hold off;
