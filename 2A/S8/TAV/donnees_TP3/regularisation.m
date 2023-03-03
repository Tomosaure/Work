function regul = regularisation(k_voisins,k_i_j,~)
    function x = delta(m,n) 
        if m ~= n
            x=0; 
        else 
            x=1; 
        end
    end
    regul = sum(sum(1-delta(k_voisins,k_i_j)));
end