function regul = regularisation(k_voisins,ks,kt)

    voisins_diff = k_voisins ~= kt;
    nb_voisins_diff = sum(voisins_diff, 'all');

    if ks == kt
        nb_voisins_diff = nb_voisins_diff - 1;
    end

    regul = nb_voisins_diff;
end