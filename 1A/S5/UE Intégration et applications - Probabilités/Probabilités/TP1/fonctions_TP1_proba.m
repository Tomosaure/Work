
% TP1 de Probabilites : fonctions a completer et rendre sur Moodle
% Nom : Bonetto
% Prénom : Tom
% Groupe : 1SN-J

function varargout = fonctions_TP1_proba(varargin)

    switch varargin{1}     
        case 'ecriture_RVB'
            varargout{1} = feval(varargin{1},varargin{2:end});
        case {'vectorisation_par_colonne','decorrelation_colonnes'}
            [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});
        case 'calcul_parametres_correlation'
            [varargout{1},varargout{2},varargout{3}] = feval(varargin{1},varargin{2:end}); 
    end

end

% Fonction ecriture_RVB (exercice_0.m) ------------------------------------
% (Copiez le corps de la fonction ecriture_RVB du fichier du meme nom)
function image_RVB = ecriture_RVB(image_originale)
canalR = image_originale(1:2:end, 2:2:end);
canalB = image_originale(2:2:end, 1:2:end);
canalV1 = image_originale(1:2:end, 1:2:end);
canalV2 = image_originale(2:2:end, 2:2:end);
canalV=(canalV1+canalV2)/2;
image_RVB = cat(3,canalR, canalV, canalB);
end

% Fonction vectorisation_par_colonne (exercice_1.m) -----------------------
function [Vd,Vg] = vectorisation_par_colonne(I)
IVG = I(:,1:end-1);
IVD = I(:,2:end);
Vg=IVG(:);
Vd=IVD(:);
end

% Fonction calcul_parametres_correlation (exercice_1.m) -------------------
function [r,a,b] = calcul_parametres_correlation(Vd,Vg)
moyenneVd = mean(Vd);
moyenneVg = mean(Vg);
varianceVd = sum((Vd-moyenneVd).^2)/size(Vd,1);
varianceVg = sum((Vg-moyenneVg).^2)/size(Vg,1);
EtVd = varianceVd^(1/2);
EtVg = varianceVg^(1/2);
A = Vd.*Vg;
covariance = sum(A-(moyenneVd*moyenneVg))/size(Vd,1);
r = covariance/(EtVd*EtVg);
a = covariance/varianceVg;
b= -a*moyenneVg+moyenneVd;
end

% Fonction decorrelation_colonnes (exercice_2.m) --------------------------
function [I_decorrelee,I_min] = decorrelation_colonnes(I,I_max)
IVG = I(:,1:end-1);
IVD = I(:,2:end);
I_decorrelee = IVD-IVG;
I_min = -I_max;
end



