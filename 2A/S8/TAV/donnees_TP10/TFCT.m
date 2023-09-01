function [Y, valeurs_t, valeurs_f] = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre)

    y_2 = buffer(y,n_fenetre, n_fenetre - n_decalage,'nodelay');

    if fenetre == "hann"
        window = hann(n_fenetre);
    else 
        window = ones(n_fenetre);
    end

    window = repmat(window,1,size(y_2,2));
    Y = fft(y_2.*window);
    Y(n_fenetre*0.5+2:end,:) = [];

    k = 0:(n_fenetre/2);
    valeurs_f = k*f_ech/n_fenetre;

    n = 0:(size(Y,2)-1);
    valeurs_t = n*n_decalage/f_ech;
end