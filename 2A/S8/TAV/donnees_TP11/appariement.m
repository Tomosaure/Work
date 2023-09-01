function paires = appariement(pics_t, pics_f, n_v, delta_t, delta_f)
    paires = [];
    n = length(pics_t);
    for i = 1:n
        compteur = 0;
        for j = 1:n
            if (pics_t(j)-pics_t(i) > 0 && pics_t(j)-pics_t(i) < delta_t && abs(pics_f(i)-pics_f(j)) < delta_f)
                if(compteur > n_v)
                    break;
                end
                paires = [paires ; pics_f(i) pics_f(j) pics_t(i) pics_t(j)];
                compteur = compteur + 1;
            end
        end
    end
end