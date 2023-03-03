function AD = attache_donnees(I,moyenne,variance)
    d = length(moyenne);
    [l,c] = size(I);
    AD = zeros(l,c,d);
    for i = 1:d
        AD(:,:,i) = 0.5*(log2(variance(i))+((I-moyenne(i)).^2)/variance(i));
    end
end