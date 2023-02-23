function beta = moindres_carres(d,x,y)
    for i = 1:d
        B(:,i) = nchoosek(i,d).*x.^k.*(1-x).^(d-i);
    end
    A = y - y(1).*(1-x).^d;
     beta = A\B;
end