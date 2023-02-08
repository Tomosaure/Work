function [Mu,Sigma] = estimation_mu_Sigma(X)
    % Nombre d'individus
    n = size(X,1);

    % Individu moyen
    %x_moyen = (1/n)*X'*ones(n,1);
    x_moyen = 0;
    % Données centrées
    X_c = X - x_moyen';

    % Matrice de variance/covariance :
    Sigma = (1/n)*(X_c)'*X_c;

    % Espérence des vecteurs;
    Mu = (1/n)*X'*ones(n,1);
end

