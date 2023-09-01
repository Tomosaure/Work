function [D,A] = nmf(Y,D_0,A_0,iter)
    D = D_0;
    A = A_0;
    for i = 1:iter
        A = A .* (D'*Y) ./ (D'*D*A);
        D = D .* (Y*A') ./ (D*(A*A'));
    end
end