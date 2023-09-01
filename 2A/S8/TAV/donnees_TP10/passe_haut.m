function Y_modifie = passe_haut(Y, valeurs_f, f)

     indice = find(valeurs_f < f);
     Y(indice,:) = 0;
     Y_modifie = Y;
     
end