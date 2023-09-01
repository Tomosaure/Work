clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% [y, f_ech] = audioread('Musiques/Ed Sheeran-Shape of You.mp3', [40*44100 50*44100]);
% [y, f_ech] = audioread('Musiques/Lizzo-Boys.mp3', [10*44100 20*44100]);
[y, f_ech] = audioread('Musiques/Michael Jackson-Beat it.mp3', [35*44100 55*44100]);

% Passage dans le domaine fréquentiel :
n_fenetre = 1024;		% Largeur de la fenêtre (en nombre de points)
n_decalage = 512;		% Décalage entre deux fenêtres (en nombre de points)
fenetre = 'hann';		% Type de la fenêtre

[Y, valeurs_t, valeurs_f] = TFCT(y,f_ech,n_fenetre,n_decalage,fenetre);
S = 20*log10(abs(Y)+eps);
% Sonagramme du mélange :
figure('Name','Sonagramme du mélange','Position',[0.4*L,0,0.6*L,0.6*H]);
imagesc(valeurs_t,valeurs_f,S);
caxis([-40 20]);
axis xy;
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Sonogramme S','Interpreter','Latex','FontSize',30);

% Séparation harmonique/percussive :
[F_h, F_p] = HPSS(abs(Y).^2);
% Figures :
figure('Name','Sonagrammes des deux sources','Position',[0.4*L,0,0.6*L,0.6*H]);
subplot(1,2,1);
imagesc(valeurs_t,valeurs_f,log10(F_h));
axis xy;
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('$\mathbf{F}_{h}$','Interpreter','Latex','FontSize',30);

subplot(1,2,2);
imagesc(valeurs_t,valeurs_f,log10(F_p));
axis xy;
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('$\mathbf{F}_{p}$','Interpreter','Latex','FontSize',30);
% Création des masques :
M_h = F_h ./ (F_h + F_p);
M_p = F_p ./ (F_h + F_p);
% M_h = F_h > F_p;
% M_p = F_p > F_h;
% Affichage des masques :
figure('Name','Masques','Position',[0.4*L,0,0.6*L,0.6*H]);
subplot(1,2,1);
imagesc(valeurs_t,valeurs_f,M_h);
axis xy; axis tight; colormap gray;
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('$\mathbf{M}_{h}$','Interpreter','Latex','FontSize',30);

subplot(1,2,2);
imagesc(valeurs_t,valeurs_f,M_p);  
axis xy; axis tight; colormap gray;
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('$\mathbf{M}_{p}$','Interpreter','Latex','FontSize',30);

% Application des masques :
Y_h_hat = M_h .* Y;
Y_p_hat = M_p .* Y;
% Affichage des sonagrammes masqués :
figure('Name','Masques','Position',[0.4*L,0,0.6*L,0.6*H]);
subplot(1,2,1);
imagesc(valeurs_t,valeurs_f,20*log10(abs(Y_h_hat+eps)));
axis xy; axis tight;
caxis([-40 20]);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('$\hat{\mathbf{S}}_{h}$','Interpreter','Latex','FontSize',30);

subplot(1,2,2);
imagesc(valeurs_t,valeurs_f,20*log10(abs(Y_p_hat+eps)));  
axis xy; axis tight;
caxis([-40 20]);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('$\hat{\mathbf{S}}_{p}$','Interpreter','Latex','FontSize',30);
% Retour dans le domaine temporel :
[y_h_hat, ~] = ITFCT(Y_h_hat,f_ech,n_decalage,fenetre);
[y_p_hat, ~] = ITFCT(Y_p_hat,f_ech,n_decalage,fenetre);

% Normalisation :
y_h_hat = min(max(y_h_hat,-1),1);
y_p_hat = min(max(y_p_hat,-1),1);

% Sauvegarde :
audiowrite('Resultats/HPSS_harmonique.wav',y_h_hat,f_ech);
audiowrite('Resultats/HPSS_percussive.wav',y_p_hat,f_ech);
audiowrite('Resultats/HPSS_mix.wav',y,f_ech);