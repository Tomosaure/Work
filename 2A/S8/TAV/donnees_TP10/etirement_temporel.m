function y_modifie = etirement_temporel(y, f_ech, v)
    Y = TFCT(y, f_ech, 2048, 512, 'hann');
    C = 1:v:size(Y,2);
    phi = angle(Y(:,1));
    Y_2 = zeros(size(Y));
    for i =1:length(C)
        c = floor(C(i));
        alpha = C(i) - c;
        rho = (1-alpha)*abs(Y(:,c)) + alpha*abs(Y(:,c+1));
        Y_2(:,i) = rho.*exp(1i*phi);
        dphi = angle(Y(:,c+1)) - angle(Y(:,c));
        phi = phi + alpha*dphi*180/pi;
    end

    y_modifie = ITFCT(Y_2, f_ech, 512, 'hann');
end