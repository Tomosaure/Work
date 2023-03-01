function beta = moindres_carres(d,x,y)
    nparmik_mat = arrayfun(@(n) nchoosek(d,n), (1:d));
    A = nparmik_mat.*x.^(1:d).*(1-x).^(d-(1:d));
    B = y - y(1).*(1-x).^d;
    beta = A\B
end