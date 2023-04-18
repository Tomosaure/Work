function f = kaczmarz(p,W,n_boucles)
    [nmesure,npixel] = size(W);
    f = zeros(npixel,1);
    kmax = n_boucles;
    Wt = W';
    W_norm = sum(W.^2,2);
    for k = 1:kmax
        for i = 1:nmesure
            if W_norm(i,:) ~= 0 
                f = f + (p(i)-Wt(:,i)'*f)/W_norm(i,:)*Wt(:,i);
            end
        end
    end
end