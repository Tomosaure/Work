clear;
close all;

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);


% Parametres :
N = 50;					% Nombre de disques d'une configuration
R = 7;					% Rayon des disques
% Parametres ajoutés :
beta = 1;
S = 140;
gamma = 5;
T_0 = 0.1;
lambda_0 = 100;
alpha = 0.99;

nb_points_affichage_disque = 30;
increment_angulaire = 2*pi/nb_points_affichage_disque;
theta = 0:increment_angulaire:2*pi;
rose = [253 108 158]/255;
q_max = 200;
nb_affichages = 1000;
pas_entre_affichages = floor(q_max/nb_affichages);
temps_pause = 0.0001;

% Lecture et affichage de l'image :
I = imread('colonie.png');
I = rgb2ycbcr(I);
I = double(I(:,:,1));
[nb_lignes,nb_colonnes] = size(I);
figure('Name',['Detection de ' num2str(N) ' flamants roses'],'Position',[0,0,L,0.58*H]);

% Tirage aleatoire d'une configuration initiale et calcul des niveaux de gris moyens :
lambda = lambda_0;
T = T_0;
c = [];
%% Ne fonctionne pas
while q_max ~= 0
    %% Naissances
    N = poissrnd(lambda);
    naissance = zeros(N,2);
    for i = 1:N
        c_nouv = [nb_colonnes*rand nb_lignes*rand];
        naissance(i,:) = c_nouv;
    end
    c = [c; naissance];

    %% Tri des disques
    U = zeros(N);
    for i = 1:N
        % Calcul de l'énergie individuelle
        U(i) = 1 - (2 / (1 + exp(-gamma*((calcul_I_moyen(I,c(i,:),R)/S) -1))));
    end
    [~, index] = sort(U, 'descend');
    c = c(index,:);

    %% Morts, pour chaque disque, calculer la probabilité de mourir et le supprimer
	morts=[];
	for i = 1:N
        idx = index(i);
		somme = sum(sqrt((c(idx,1) - c(:,1)).^2 + (c(idx,2) - c(:,2)).^2) <= sqrt(2)*R)-1;
		p = lambda / (lambda + exp(-U(idx)-beta*somme)/T);
		% Si le nombre aléatoire est inférieur à la probabilité de mort, on supprime le disque
		if rand() < p
		    morts = [morts; i];
        else
            U = U + beta*somme;
        end
    end

	% Suppression des disques
	c(morts,:) = [];
	U(morts) = [];

	%% Convergence
	T = alpha*T;
	lambda = lambda*alpha;
	q_max = q_max - 1

	%% Affichage de la configuration initiale :
	subplot(1,2,1);
	imagesc(I);
	axis image;
	axis off;
	colormap gray;
	hold on;

	for i = 1:N
		x_affich = c(i,1)+R*cos(theta);
		y_affich = c(i,2)+R*sin(theta);
		indices = find(x_affich>0 & x_affich<nb_colonnes & y_affich>0 & y_affich<nb_lignes);
		plot(x_affich(indices),y_affich(indices),'Color',rose,'LineWidth',3);
	end
	
	pause(temps_pause);
end