function [U,k] = recuit(U,k,AD,T,beta)
    [l,c,N] = size(AD);
    for i = 1:l
        for j = 1:c
            valeur = setdiff(1:N,k);
            k_nouv = valeur(randi(numel(valeur)));

        end
    end
end