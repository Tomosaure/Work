clear all;
close all;

load eigenfaces;

h = figure('Position',[0,0,0.67*L,0.67*H]);
figure('Name','RMSE en fonction du nombre de composantes principales','Position',[0.67*L,0,0.33*L,0.3*L]);

% Calcul de la RMSE entre images originales et images reconstruites :
RMSE_max = 0;

% Composantes principales des données d'apprentissage
C = X_centre*W;

 for q = 0:n-1
     Composantes_principales = C(:,1:q);		% q premières composantes principales  %ici
     Eigenfaces_principales = W(:,1:q);		% q premières eigenfaces  %ici
     X_reconstruit = Eigenfaces_principales*Composantes_principales' + repmat(individu_moyen',1,n);
     %X_reconstruit = X_centre*Eigenfaces_principales*Eigenfaces_principales' + individu_moyen;

     figure(1);
     set(h,'Name',['Utilisation des ' num2str(q) ' premieres composantes principales']);
     colormap gray;
     hold off;
     img = reshape(individu_moyen, nb_lignes, nb_colonnes);
     subplot(nb_personnes_base, nb_postures_base, 1)
     imagesc(img); 
     hold on;
     for k = 1:n
         subplot(nb_personnes_base, nb_postures_base,k);
         img = reshape(X_reconstruit(:,k),nb_lignes,nb_colonnes); %ici
         imagesc(img);
         hold on;
         axis image;
         axis off;
     end
     
    figure(2);
    hold on;

    RMSE = sqrt(mean(mean((X-X_reconstruit').^2)));

    RMSE_max = max(RMSE,RMSE_max);

    plot(q,RMSE,'r+','MarkerSize',8,'LineWidth',2);
    axis([0 n-1 0 1.1*RMSE_max]);
    set(gca,'FontSize',20);
    hx = xlabel('$q$','FontSize',30);
    set(hx,'Interpreter','Latex');
    ylabel('RMSE','FontSize',30);
    
    %pause(0.01);
end

save projection;

