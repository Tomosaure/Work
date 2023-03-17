clear;
%close all;
% Nombre d'images utilisees
nb_images = 36; 

% chargement des images
for i = 1:nb_images
    if i<=10
        nom = sprintf('images/viff.00%d.ppm',i-1);
    else
        nom = sprintf('images/viff.0%d.ppm',i-1);
    end
    % im est une matrice de dimension 4 qui contient 
    % l'ensemble des images couleur de taille : nb_lignes x nb_colonnes x nb_canaux 
    % im est donc de dimension nb_lignes x nb_colonnes x nb_canaux x nb_images
    im(:,:,:,i) = imread(nom); 
end

% Affichage des images
figure; 
subplot(2,2,1); imshow(im(:,:,:,1)); title('Image 1');
subplot(2,2,2); imshow(im(:,:,:,9)); title('Image 9');
subplot(2,2,3); imshow(im(:,:,:,17)); title('Image 17');
subplot(2,2,4); imshow(im(:,:,:,25)); title('Image 25');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A COMPLETER                                             %
% Calculs des superpixels                                 % 
% Conseil : afficher les germes + les régions             %
% à chaque étape / à chaque itération                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ........................................................%
k = 100;
[m,n] = size(im(:,:,1,1));
s = sqrt(m*n/k);
centre = zeros(k-1,5);
% initilisa tion des centres répartis sur l'image de manière homogène avec meshgrid
[XX,YY] = meshgrid(s/2:s:m,s/2:s:n);
abs_centre=(XX');
abs_centre=abs_centre(:);
ord_centre=(YY');
ord_centre=ord_centre(:);
centre(:,4)=abs_centre;
centre(:,5)=ord_centre;

% on affine la grille
im_1=im2double(im(:,:,:,1));
[Gmag, Gdir] = imgradient(rgb2gray(im(:,:,:,1)));
imshow(Gmag, []);
n_affinage=3;
centre_avant=centre;
for i = 1:99
    % gradient dans le voisinage 
     gradient_k = Gmag(max(centre(i,4)-n_affinage,1):min(centre(i,4)+n_affinage,m),max(centre(i,5)-n_affinage,1):min(centre(i,5)+n_affinage,n));
    % on choisit le minimum
    [min_val, min_ind] = min(gradient_k(:));
    [row, col] = ind2sub(size(gradient_k), min_ind);
    centre(i,1)=im_1(round(centre(i,4)+row-(n_affinage+1)),round(centre(i,5)+col-(n_affinage+1)),1);
    centre(i,2)=im_1(round(centre(i,4)+row-(n_affinage+1)),round(centre(i,5)+col-(n_affinage+1)),2);
    centre(i,3)=im_1(round(centre(i,4)+row-(n_affinage+1)),round(centre(i,5)+col-(n_affinage+1)),3);
    
    centre(i,4) =  round(centre(i,4)+row-(n_affinage+1));
    centre(i,5) = round(centre(i,5)+col-(n_affinage+1));

end
%% on affiche la grille sur l'image
figure;
imshow(im(:,:,:,1));
hold on;
plot(centre(:,5),centre(:,4),'r*');
hold on;
plot(centre_avant(:,5),centre_avant(:,4),'g*');

hold off;
%% Evolution des centres de chaque pixel:
pixel_kmeans = zeros(n*m,5);
l=1;
%pixel_kmeans=im2double(pixel_kmeans);
for i=1:m
    for j=1:n
        pixel_kmeans(l,:)=[im_1(i,j,1) im_1(i,j,2) im_1(i,j,3) i j];
        l=l+1;
    end
end
m_S=1;
pixel_kmeans_copie=pixel_kmeans;
centre(:,4)= centre(:,4)*(m_S/s);
centre(:,5)=centre(:,5)*(m_S/s);
pixel_kmeans(:,4)=pixel_kmeans(:,4)*(m_S/s);
pixel_kmeans(:,5)=pixel_kmeans(:,5)*(m_S/s);
%% IDX est un vecteur colonne qui indique à quel cluster chaque pixel de l'image a été assigné
%% C est une matrice qui contient les centres des K clusters
[idx, C] = kmeans(pixel_kmeans,k-1,'Start',centre,'MaxIter',100);
C(:,4)= C(:,4)*(s/m_S);
C(:,5)=C(:,5)*(s/m_S);
% Adapation 
[nb_lignes, nb_colonnes, ~]=size(im);
idx=(reshape(idx,size(im_1,2),size(im_1,1)))';
figure
mask=boundarymask(idx);
imshow(labeloverlay(im_1,mask,'Transparency',0))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A COMPLETER                                             %
% Binarisation de l'image à partir des superpixels        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ........................................................%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A FAIRE SI VOUS UTILISEZ LES MASQUES BINAIRES FOURNIS   %
% Chargement des masques binaires                         %
% de taille nb_lignes x nb_colonnes x nb_images           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ... 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A DECOMMENTER ET COMPLETER                              %
% quand vous aurez les images segmentées                  %
% Affichage des masques associes                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure;
% subplot(2,2,1); ... ; title('Masque image 1');
% subplot(2,2,2); ... ; title('Masque image 9');
% subplot(2,2,3); ... ; title('Masque image 17');
% subplot(2,2,4); ... ; title('Masque image 25');

% chargement des points 2D suivis 
% pts de taille nb_points x (2 x nb_images)
% sur chaque ligne de pts 
% tous les appariements possibles pour un point 3D donne
% on affiche les coordonnees (xi,yi) de Pi dans les colonnes 2i-1 et 2i
% tout le reste vaut -1
pts = load('viff.xy');
% Chargement des matrices de projection
% Chaque P{i} contient la matrice de projection associee a l'image i 
% RAPPEL : P{i} est de taille 3 x 4
load dino_Ps;

% Reconstruction des points 3D
X = []; % Contient les coordonnees des points en 3D
color = []; % Contient la couleur associee
% Pour chaque couple de points apparies
for i = 1:size(pts,1)
    % Recuperation des ensembles de points apparies
    l = find(pts(i,1:2:end)~=-1);
    % Verification qu'il existe bien des points apparies dans cette image
    if size(l,2) > 1 & max(l)-min(l) > 1 & max(l)-min(l) < 36
        A = [];
        R = 0;
        G = 0;
        B = 0;
        % Pour chaque point recupere, calcul des coordonnees en 3D
        for j = l
            A = [A;P{j}(1,:)-pts(i,(j-1)*2+1)*P{j}(3,:);
            P{j}(2,:)-pts(i,(j-1)*2+2)*P{j}(3,:)];
            R = R + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),1,j));
            G = G + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),2,j));
            B = B + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),3,j));
        end;
        [U,S,V] = svd(A);
        X = [X V(:,end)/V(end,end)];
        color = [color [R/size(l,2);G/size(l,2);B/size(l,2)]];
    end;
end;
fprintf('Calcul des points 3D termine : %d points trouves. \n',size(X,2));

%affichage du nuage de points 3D
figure;
hold on;
for i = 1:size(X,2)
    plot3(X(1,i),X(2,i),X(3,i),'.','col',color(:,i)/255);
end;
axis equal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A COMPLETER                  %
% Tetraedrisation de Delaunay  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T = ...                      

% A DECOMMENTER POUR AFFICHER LE MAILLAGE
% fprintf('Tetraedrisation terminee : %d tetraedres trouves. \n',size(T,1));
% Affichage de la tetraedrisation de Delaunay
% figure;
% tetramesh(T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A DECOMMENTER ET A COMPLETER %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul des barycentres de chacun des tetraedres
% poids = ... 
% nb_barycentres = ... 
% for i = 1:size(T,1)
    % Calcul des barycentres differents en fonction des poids differents
    % En commencant par le barycentre avec poids uniformes
%     C_g(:,i,1)=[ ...

% A DECOMMENTER POUR VERIFICATION 
% A RE-COMMENTER UNE FOIS LA VERIFICATION FAITE
% Visualisation pour vérifier le bon calcul des barycentres
% for i = 1:nb_images
%    for k = 1:nb_barycentres
%        o = P{i}*C_g(:,:,k);
%        o = o./repmat(o(3,:),3,1);
%        imshow(im_mask(:,:,i));
%        hold on;
%        plot(o(2,:),o(1,:),'rx');
%        pause;
%        close;
%    end
%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A DECOMMENTER ET A COMPLETER %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copie de la triangulation pour pouvoir supprimer des tetraedres
% tri=T.Triangulation;
% Retrait des tetraedres dont au moins un des barycentres 
% ne se trouvent pas dans au moins un des masques des images de travail
% Pour chaque barycentre
% for k=1:nb_barycentres
% ...

% A DECOMMENTER POUR AFFICHER LE MAILLAGE RESULTAT
% Affichage des tetraedres restants
% fprintf('Retrait des tetraedres exterieurs a la forme 3D termine : %d tetraedres restants. \n',size(Tbis,1));
% figure;
% trisurf(tri,X(1,:),X(2,:),X(3,:));

% Sauvegarde des donnees
% save donnees;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSEIL : A METTRE DANS UN AUTRE SCRIPT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load donnees;
% Calcul des faces du maillage à garder
% FACES = ...;
% ...

% fprintf('Calcul du maillage final termine : %d faces. \n',size(FACES,1));

% Affichage du maillage final
% figure;
% hold on
% for i = 1:size(FACES,1)
%    plot3([X(1,FACES(i,1)) X(1,FACES(i,2))],[X(2,FACES(i,1)) X(2,FACES(i,2))],[X(3,FACES(i,1)) X(3,FACES(i,2))],'r');
%    plot3([X(1,FACES(i,1)) X(1,FACES(i,3))],[X(2,FACES(i,1)) X(2,FACES(i,3))],[X(3,FACES(i,1)) X(3,FACES(i,3))],'r');
%    plot3([X(1,FACES(i,3)) X(1,FACES(i,2))],[X(2,FACES(i,3)) X(2,FACES(i,2))],[X(3,FACES(i,3)) X(3,FACES(i,2))],'r');
% end;