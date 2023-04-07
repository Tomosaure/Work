function u = collage(r,s,interieur)

s = im2double(s);
r = im2double(r);

u=r; 

[c,l] = size(u);

nb_pixels = c*l;

e = ones(nb_pixels,1);

Dx = spdiags([-e e],[0 l],nb_pixels,nb_pixels);
Dx(end-l+1:end,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(l:l:end,:) = 0;

A = -Dxr'*Dx-Dy'*Dy;

indice_bord = [A(1,:) ; A(end,:) ; A(:,1) ; A(:,end)];
[cb,lb] = size(indice_bord);
n_bord = cb*lb;

A(indices_bord,:) = sparse(1:n_bord,indices_bord,ones(n_bord,1),n_bord,nb_pixels);

for k = 1:size(r,3)

	u_k = u(:,:,k);
	s_k = s(:,:,k);

    g_x = Dx*u_k;
    g_y = Dy*u_k;
    g_x(interieur) = Dx*s_k;
    g_y(interieur) = Dy*s_k;

    b_k = Dx*g_x + D_y*g_y;

    u_k = A\b_k;

	u(:,:,k) = reshape(u_k,c,l);
end
