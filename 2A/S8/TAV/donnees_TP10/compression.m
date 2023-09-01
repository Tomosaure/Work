function [Y_modifie, compression_rate] = compression(Y, f)
    Y_mod = abs(Y);
    [~,indice] = maxk(Y_mod,f);
        
    Y_2 = Y;

    for i=1:size(Y,2)
        Y_2(indice(:,i),i) = 0;
    end
    Y_modifie = Y - Y_2;
    
    num_nonzero_values = numel(Y_modifie)-nnz(Y_modifie);
    total_values = numel(Y);
    compression_rate = (num_nonzero_values / total_values) * 100;
end