function [centers, labels] = kmoyenne(data, k, itermax)
    
    % Initialisation des centres en attribuant une valeur d'intensité différente à chaque centre
    centers = zeros(k, 3);
    for i = 1:k
        centers(i, 3) = (255/k) * (i-1);
    end
    
    % Initialisation du vecteur des labels
    labels = zeros(size(data));
    
    % Boucle principale de l'algorithme k-means
    convergence = false;
    EPSILON = 0.01;
    
    compt = 0;
    while ~convergence && compt < itermax
        % Attribution des étiquettes de cluster à chaque pixel
        for i = 1:numel(data)
            min_dist = 255;
            index = 0;
            for j = 1:k
                dist = abs(double(data(i)) - centers(j, 3));
                if dist < min_dist
                    min_dist = dist;
                    index = j;
                end
            end
            labels(i) = index;
        end
        
        % Calcul des nouveaux centres
        for j = 1:k
            sum = 0;
            count = 0;
            for i = 1:numel(data)
                if labels(i) == j
                    sum = sum + double(data(i));
                    count = count + 1;
                end
            end
            newCenter = sum / count;
            
            % Vérification de la convergence
            if abs(newCenter - centers(j, 3)) < EPSILON
                convergence = true;
            else
                convergence = false;
                centers(j, 3) = newCenter;
                compt = compt + 1;
                break;
            end
        end
    end

    % Retourner les résultats
    centers(:, 1:2) = 255;
end