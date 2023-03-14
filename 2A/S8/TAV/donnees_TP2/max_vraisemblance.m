function parametres_MV = max_vraisemblance(D_app,parametres_test)
    nb = size(parametres_test,1);
    arg = zeros(nb,1);
    for i = 1:nb
        r = calcul_r(D_app,parametres_test(i,:));
        arg(i) = sum(r.^2);
    end
    [~,minimiseur] = min(arg);
     parametres_MV= parametres_test(minimiseur,:);
end