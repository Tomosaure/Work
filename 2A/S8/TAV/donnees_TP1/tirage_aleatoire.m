function [y_inf,y_sup] = tirage_aleatoire(x,moyennes,ecarts_types,beta_0,gamma_0)
    d = length(ecarts_types);
    parametres = randn(d,1).*ecarts_types+moyennes;
    d = (d+1)/2;
    eps = parametres(end);
    beta = parametres(1:d-1);
    gamma = parametres(d:end-1);
    y_inf = bezier(x,beta_0,[beta;eps]);
    y_sup = bezier(x,gamma_0,[gamma;eps]);
end