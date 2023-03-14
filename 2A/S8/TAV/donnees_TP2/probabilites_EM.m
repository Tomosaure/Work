function probas = probabilites_EM(D_app,parametres_estim,proportion_1,proportion_2,sigma)
    coef1 = proportion_1 / sigma ;
    coef2 = proportion_2 / sigma;
    r1 = ( calcul_r(D_app,parametres_estim(1,:)) ).^2;
    r2 = ( calcul_r(D_app,parametres_estim(2,:)) ).^2;
    r1_exp = exp(-r1 / (2*sigma^2));
    r2_exp = exp(-r2 / (2*sigma^2));
    denom = coef1*r1_exp + coef2*r2_exp;
    probas = [coef1 * r1_exp ; coef2 * r2_exp]./denom;
end