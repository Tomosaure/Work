function [U,k] = recuit(U,k,AD,T,beta)
    [l,c,N] = size(AD);
    for i = 1:l
        for j = 1:c
            valeur = setdiff(1:N,k);
            k_nouv = valeur(randi(numel(valeur)));
            Us = AD(i,j,k_nouv) + beta*regularisation();
            if Us < U
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