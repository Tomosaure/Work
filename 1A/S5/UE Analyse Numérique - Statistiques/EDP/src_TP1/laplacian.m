function L = laplacian(nu,dx1,dx2,N1,N2)
%
%  Cette fonction construit la matrice de l'op�rateur Laplacien 2D anisotrope
%
%  Inputs
%  ------
%
%  nu : nu=[nu1;nu2], coefficients de diffusivit� dans les dierctions x1 et x2. 
%
%  dx1 : pas d'espace dans la direction x1.
%
%  dx2 : pas d'espace dans la direction x2.
%
%  N1 : nombre de points de grille dans la direction x1.
%
%  N2 : nombre de points de grilles dans la direction x2.
%
%  Outputs:
%  -------
%
%  L      : Matrice de l'op�rateur Laplacien (dimension N1N2 x N1N2)
%
% 

% Initialisation
L=sparse([]);

n = N1*N2;
d= (nu(1)/dx1^2+nu(2)/dx2^2)*ones(n,1);
d3 = (-nu(1)/dx1^2)*ones(n,1);
d2 = (-nu(2)/dx2^2)*ones(n,1);
L = spdiags([d3 d2 2*d d2 d3], [-N2 -1 0 1 N2],n,n);
for i=1:N1 
    L((N2+1)*i,N2*i) = 0;
end

end    
