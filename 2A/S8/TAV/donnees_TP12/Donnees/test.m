close all;
clear all;

% Chargement du fichier audio
[y, f_ech] = audioread('Musiques/Au clair de la lune.wav');

% Paramètres du sonagramme
n_fenetre = 1024;		% Largeur de la fenêtre (en nombre de points)
n_decalage = 512;		% Décalage entre deux fenêtres (en nombre de points)
fenetre = 'hann';	

% Calcul du sonagramme
[Y, valeurs_t, valeurs_f] = TFCT(y,f_ech,n_fenetre,n_decalage,fenetre);
S = 20*log10(abs(Y)+eps);

% Affichage du sonagramme
figure;
imagesc(valeurs_t, valeurs_f, S);
caxis([-40 20]);
axis xy;
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('$\mathbf{S}_{h}$','Interpreter','Latex','FontSize',30);

% Calcul de la transformation de Fourier 2D
tf2d = fftshift(fft2(S));

% Affichage de la transformation de Fourier 2D
figure;
imagesc(20*log10(abs(tf2d)));
axis xy;
colorbar;
xlabel('Fréquence');
ylabel('Fréquence');
title('Transformation de Fourier 2D');

% Identification des pics pertinents
seuil = 0.9; % Seuil pour la détection des pics
indices_pics = find(abs(tf2d) > seuil);

% Création des masques
masque1 = zeros(size(tf2d));
masque2 = zeros(size(tf2d));
masque1(indices_pics) = 1;
masque2(indices_pics) = 1 - masque1(indices_pics);

% Application des masques à la transformation de Fourier 2D
tf2d_source1 = tf2d .* masque1;
tf2d_source2 = tf2d .* masque2;

% Inversion de la transformation de Fourier 2D pour chaque source
source1 = abs(ifft2(ifftshift(tf2d_source1)));
source2 = abs(ifft2(ifftshift(tf2d_source2)));

% Normalisation des sources
source1 = source1 / max(abs(source1(:)));
source2 = source2 / max(abs(source2(:)));

% Lecture des sources séparées
audiowrite('Resultats/Test_harmonique.wav',source1,f_ech);
audiowrite('Resultats/Test_percussive.wav',source2,f_ech);

