function f = retroprojection(sinogramme,theta,nb_rayons,nb_lignes,nb_colonnes)
    f = zeros(nb_lignes,nb_colonnes);
    for i = 1:nb_lignes
        for j = 1:nb_colonnes
            s = 0;
            for k = 1:length(theta)
                x = j-round(nb_colonnes/2);
                y = round(nb_lignes/2)-i;
                angle = theta(k)*pi/180;
                t = round(x*cos(angle)+y*sin(angle)+nb_rayons/2);
                s = s + sinogramme(t,k)*t;
            end
            f(i,j) = s/nb_rayons;
        end
    end
end