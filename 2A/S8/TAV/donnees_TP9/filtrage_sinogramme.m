function f = filtrage_sinogramme(sinogramme,nb_theta, nb_rayons)
    F = fftshift(fft(sinogramme));

    filter = abs(linspace(-1,1,nb_rayons));
    F_filtered = ifftshift(F .* repmat(filter',1,nb_theta));
    
    f = real(ifft(F_filtered));
end