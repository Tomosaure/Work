function solutions = moindres_carres_paire(d,x,y_inf,y_sup)
    p = length(x);

    nparmik_mat = arrayfun(@(n) nchoosek(d,n), (1:(d-1)));
    a = nparmik_mat.*x.^(1:(d-1)).*(1-x).^(d-(1:(d-1)));

    A = zeros(2*p,2*d-1);
    A(1:p,1:(d-1)) = a;
    A(p+1:end,d:(2*d-2)) = a;
    A(:,2*d-1) = [x.^d;x.^d];

    B1 = y_inf - y_inf(1).*(1-x).^d;
    B2 = y_sup - y_sup(1).*(1-x).^d;
    B = [B1;B2];

    solutions = A\B;
end