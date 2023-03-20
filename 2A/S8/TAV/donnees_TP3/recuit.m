function [U,k] = recuit(U,k,AD,T,beta)
    [l,c,N] = size(AD);
    for i = 1:l
        for j = 1:c
            valeur = setdiff(1:N,k(i,j));
            k_nouv = valeur(randi(numel(valeur)));

            k_voisins = k(max(i-1,1):min(i+1,l) , max(j-1,1):min(j+1,c));
            Us = AD(i,j,k_nouv) + beta*regularisation(k_voisins, k(i,j), k_nouv);

            if Us < U(i,j)
                U(i,j) = Us;
                k(i,j) = k_nouv;
            else
                if rand() < exp(-(Us-U(i,j))/T)
                    U(i,j) = Us;
                    k(i,j) = k_nouv;
                end
            end

        end
    end
end