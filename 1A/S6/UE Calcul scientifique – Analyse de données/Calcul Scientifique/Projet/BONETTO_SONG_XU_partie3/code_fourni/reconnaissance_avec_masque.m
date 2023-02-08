
clear;
close all;

load eigenfaces_part3;

% Tirage aléatoire d'une image de test :
personne = randi(nb_personnes);
posture = randi(nb_postures);
% si on veut tester/mettre au point, on fixe l'individu
 personne = 22;
 posture = 5;

ficF = strcat('./Data/', liste_personnes{personne}, liste_postures{posture}, '-300x400.gif')
img = imread(ficF);
% on rajoute le masque
ligne_min = 200;ligne_max = 350;
colonne_min = 60;
colonne_max = 290;
img(ligne_min:ligne_max,colonne_min:colonne_max) = 0;

image_test = double(transpose(img(:)));
 


% Nombre q de composantes principales à prendre en compte 
q = 2;

% dans un second temps, q peut être calculé afin d'atteindre le pourcentage
% d'information avec q valeurs propres (contraste)
% Pourcentage d'information 
% per = 0.75;

% Composantes principales des images d'apprentissages
DataA = X_centre_masque*W_masque(:,1:q);
% Composantes principales de l'image test
DataT = image_test - individu_moyen_masque;   %% Centrage
DataT = DataT*W_masque(:,1:q);                 %% calcul de la composante principale
% Choix du nombre de voisins
K = 2;


ListeClass1 = 1:6;
LabelA1 = repmat(ListeClass1,1,nb_personnes_base);

ListeClass2 = 1:32;
LabelA2 = repelem(ListeClass2,6);

% Nombre d'images test

Nt_Test = 1;                                         %%% 1 seul individu

%Appel du classifieur kppv sur les q composantes principales
[Partition1] = kppv(DataA, LabelA1 ,DataT,Nt_Test, K, ListeClass1);              %% posture
[Partition2] = kppv(DataA, LabelA2 ,DataT,Nt_Test, K, ListeClass2);              %% personne


% individu pseudo-résultat pour l'affichage 
posture_proche = Partition1;
personne_proche = Partition2;


% [Indice] = bayesien(DataA, DataT);
% 
% % pour l'affichage (A CHANGER)
% for i = 1 : length(Indice)
%     if rem(Indice(i),nb_postures_base) == 0
%         posture_proche(i) = nb_postures_base;
%         personne_proche(i) = floor(Indice(i)/nb_postures_base);
% 
%     else
%         posture_proche(i) = rem(Indice(i),nb_postures_base);
%         personne_proche(i) = floor(Indice(i)/nb_postures_base) + 1;
%     end  
% end
% 
% posture_proche = freq(posture_proche);
% personne_proche = freq(personne_proche);

figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);

subplot(1, 2, 1);
% Affichage de l'image de test :
colormap gray;
imagesc(img);
title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes{personne}]}, 'FontSize', 20);
axis image;

ficF = strcat('./Data/', liste_personnes_base{personne_proche}, liste_postures{posture_proche}, '-300x400.gif')
img = imread(ficF);
        
subplot(1, 2, 2);
imagesc(img);
image_predite = double(transpose(img(:)));
confusionmat(image_test, image_predite)
title({['Individu la plus proche : posture ' num2str(posture_proche) ' de ', liste_personnes_base{personne_proche}]}, 'FontSize', 20);
axis image;
