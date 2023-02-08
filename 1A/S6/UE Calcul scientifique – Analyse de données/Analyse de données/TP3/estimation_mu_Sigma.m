function [mu, sigma] = estimation_mu_Sigma(X)
    [n,~] = size(X);
    mu = mean(X);
    Xc = X - mu;
    sigma = (Xc'*Xc)/n;
    mu = mu';
end
