function u = collage(r,s,interieur)

s = double(s);
r = double(r);

[l,c,~] = size(r);

nb_pixels = c*l;

e = ones(nb_pixels,1);

Dx = spdiags([-e e],[0 l],nb_pixels,nb_pixels);
Dx(end-l+1:end,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(l:l:end,:) = 0;

A = -Dx'*Dx-Dy'*Dy;

m = zeros(l,c);
m(2:end-1,2:end-1) = 1;
indices_bord = find(m==0);
[cb,lb] = size(indices_bord);
n_bord = cb*lb;

A(indices_bord,:) = sparse(1:n_bord,indices_bord,ones(n_bord,1),n_bord,nb_pixels);

u=r; 

for k = 1:size(r,3)

	u_k = u(:,:,k);
	s_k = s(:,:,k);

    gr_x = Dx*u_k(:);
    gr_y = Dy*u_k(:);
    
    gs_x = Dx*s_k(:);
    gs_y = Dy*s_k(:);
    
    gr_x(interieur) = gs_x(interieur);
    gr_y(interieur) = gs_y(interieur);

    b_k = Dx*gr_x + Dy*gr_y;
    b_k(indices_bord) = u_k(indices_bord);

    u_k = A\b_k;

	u(:,:,k) = reshape(u_k,l,c);
end
