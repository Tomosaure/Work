function u_barre_new = calcul_structure_2(u_barre,b,Dx,Dy,lambda,epsilon)
    u_barre_reshaped = reshape(u_barre,size(u_barre,1)*size(u_barre,1),1);
    N = length(b);
    W = spdiags( 1 ./ sqrt( (Dx*u_barre_reshaped).^2 + (Dy*u_barre_reshaped).^2 + epsilon), 0, N, N);
    I = speye(N);
    A = I - lambda*(-Dx'*W*Dx-Dy'*W*Dy);
    u_barre_new = A\u_barre_reshaped;
    u_barre_new = reshape(u_barre_new,size(u_barre,1),size(u_barre,2),1);
end