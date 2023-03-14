function probas = probabilites(D_app,parametres_estim,sigma)
    pi = 0.5;
    coef = pi / (sigma * sqrt(2 * pi));
    r1 = ( calcul_r(D_app,parametres_estim(1,:)) ).^2;
    r2 = ( calcul_r(D_app,parametres_estim(2,:)) ).^2;
    r1_exp = exp(-r1 / (2*sigma^2));
    r2_exp = exp(-r2 / (2*sigma^2));
    probas = [coef * r1_exp ; coef * r2_exp];
end