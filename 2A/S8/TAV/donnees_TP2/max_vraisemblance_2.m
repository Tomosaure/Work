function parametres_MV = max_vraisemblance_2(D_app,parametres_test,sigma)
    nb = size(parametres_test,1);
    arg = zeros(nb,1);
    pi = 0.5;
    ps = pi/sigma;
    for i = 1:nb
        r1 = calcul_r(D_app,parametres_test(i,1,:));
        r2 = calcul_r(D_app,parametres_test(i,2,:));
        arg(i) = sum( log(ps * exp(-r1.^2 /  (2 * sigma^2)) + ps * exp(-r2.^2 / (2 * sigma^2))));
    end
    [~,minimiseur] = max(arg);
     parametres_MV= parametres_test(minimiseur,:);
end