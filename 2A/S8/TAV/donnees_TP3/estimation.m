function [moyenne,variance] = estimation(echantillons)
    moyenne = mean(echantillons,2);
    variance = var(echantillons);
end