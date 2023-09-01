clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Lecture d'un fichier audio
[y, f_ech] = audioread('Audio/Lights.mp3');
y = mean(y, 2);
compression_rate = 0;
% Calcul de la transformée de Fourier à court terme :
n_fenetre = 2048;		% Largeur de la fenêtre (en nombre d'échantillons)
n_decalage = 512;		% Décalage entre positions successives de la fenêtre (en nombre d'échantillons)
fenetre = 'hann';		% Type de la fenêtre : 'rect' ou 'hann'

% Calcul de la TFCT :
[Y, valeurs_t, valeurs_f] = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre);

% Affichage du sonagramme original, en guise de comparaison :
figure(Name='Modification du spectrogramme', Position=[0,0,L,0.6*H]);
subplot(1,2,1);
imagesc(valeurs_t, valeurs_f,20*log10(abs(Y)), [-60, 40]);
axis xy;
set(gca, FontSize=20);
xlabel('Temps ($s$)', Interpreter='Latex', FontSize=20);
xlabel('Frequence ($Hz$)', Interpreter='Latex', FontSize=20);
title('Sonagramme original', FontSize=15);

% Ajout d'un effet
%Y_modifie = passe_bas(Y, valeurs_f, 5000);
%Y_modifie = passe_haut(Y, valeurs_f, 5000);
%[Y_modifie, compression_rate] = compression(Y, 100);
[Y_modifie, compression_rate] = compression2(Y, 15, valeurs_f);

% Affichage de la TFCT reconstituée :
subplot(1,2,2);
imagesc(valeurs_t,valeurs_f,20*log10(abs(Y_modifie) + eps), [-60, 40]);
axis xy;
set(gca, FontSize=20);
xlabel('Temps ($s$)', Interpreter='Latex', FontSize=30);
xlabel('Frequence ($Hz$)', Interpreter='Latex', FontSize=30);
title(['Sonagramme compressé : ' num2str(round(compression_rate)),'%'], FontSize=15);

% Calcul de la transformée de Fourier inverse :
[signal_modifie, ~] = ITFCT(Y_modifie, f_ech, n_decalage, fenetre);

% Lecture
player = audioplayer(signal_modifie, f_ech);

disp(['Compression Rate: ', num2str(compression_rate), '%']);

% Animation
play(player);

function update(obj, event, player, f_ech, h)
	n = player.CurrentSample;
	h.Value = n / f_ech;
end
