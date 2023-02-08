%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% tp.m
%--------------------------------------------------------------------------

clear
close all
clc

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

%% Calcul de la perte d'orthogonalite

% Rang de la matrice
n = 4;

% Puissance de 10 maximale pour le conditionnement
k = 16;

% Matrice U de test
U = gallery('orthog',n);
U= single(U); k =8;
% Matrice de reference
D = eye(n);

% Initialisation de la matrice pour recuperer les pertes d'orthogonalite
po = zeros(2,k);

for i = 1:k
  
  % Conditionnement de la matrice A
  %TO DO: modifier D pour obtenir A tel K(A)=10^k
  D(1,1) = 10^i;
  A = U*D*U';
  
  % Perte d'orthogonalite avec algorithme classique
  Qcgs = cgs(A);
  Qcgs2 = cgs(Qcgs);
  Qcgs3 = cgs(cgs(cgs(Qcgs)));
  Qcgs4 = cgs(Qcgs2);
  po(1,i) = norm(eye(n)-Qcgs'*Qcgs);
  po2(1,i) = norm(eye(n)-Qcgs2'*Qcgs2);
  po3(1,i) = norm(eye(n)-Qcgs3'*Qcgs3);
  po4(1,i) = norm(eye(n)-Qcgs4'*Qcgs4);
  % Perte d'orthogonalite avec algorithme modifie
  Qmgs = mgs(A);
  Qmgs2 = mgs(Qmgs);
  Qmgs3 = mgs(mgs(mgs(Qmgs)));
  po(2,i) = norm(eye(n)-Qmgs'*Qmgs);
  po2(2,i) = norm(eye(n)-Qmgs2'*Qmgs2);
  po3(2,i) = norm(eye(n)-Qmgs3'*Qmgs3);
end

%% Affichage des courbes d'erreur

x = 10.^(1:k);

figure('Position',[0.1*L,0.1*H,0.8*L,0.75*H])

    loglog(x,po(1,:),'r','lineWidth',2)
    hold on
    loglog(x,po(2,:),'b--','lineWidth',2)
    loglog(x,po2(1,:),'y','lineWidth',2)
    hold on
    loglog(x,po2(2,:),'g--','lineWidth',2)
    loglog(x,po3(1,:),'y--','lineWidth',2)
    hold on
    loglog(x,po3(2,:),'r--','lineWidth',2)
    grid on
    leg = legend('Gram-Schmidt classique',...
                 'Gram-Schmidt modifie',...
                 'Location','NorthWest');
    set(leg,'FontSize',14);
    xlim([x(1) x(end)])
    hx = xlabel('\textbf{Conditionnement $\mathbf{\kappa(A_k)}$}',...
                'FontSize',14,'FontWeight','bold');
    set(hx,'Interpreter','Latex')
    hy = ylabel('$\mathbf{|| I - Q_k^\top Q_k ||}$','FontSize',14,'FontWeight','bold');
    set(hy,'Interpreter','Latex')
    title('Evolution de la perte d''orthogonalite en fonction du conditionnement',...
          'FontSize',20)


