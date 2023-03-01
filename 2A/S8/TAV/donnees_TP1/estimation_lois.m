function [moyennes,ecart_types] = estimation_lois(liste_parametres)
    moyennes = mean(liste_parametres,2);
    ecart_types = sqrt(sum((liste_parametres-moyennes).^2,2)/length(moyennes));
end