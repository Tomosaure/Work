function y = bezier(x,arg0,arg)
    d = length(arg);
    nparmik_mat = arrayfun(@(n) nchoosek(d,n), (1:d));
    y = arg0*(1-x).^d + sum(arg'.*nparmik_mat.*x.^(1:d).*(1-x).^(d-(1:d)),2);
end