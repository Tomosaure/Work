function [F_h, F_p] = HPSS(Y)
    [n1,n2] = size(Y);
    F_h = medfilt2(Y,[1 n2]);
    F_p = medfilt2(Y,[n1 1]);
end