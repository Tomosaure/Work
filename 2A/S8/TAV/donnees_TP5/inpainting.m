function u_kp1 = inpainting(b,u_k,lambda,Dx,Dy,epsilon,defaut)
    N = length(b);
    W = spdiags( 1 ./ sqrt( (Dx*u_k).^2 + (Dy*u_k).^2 + epsilon), 0, N, N);
    Wd = spdiags(1-defaut./255,0 ,N ,N);
    A = Wd - lambda*(-Dx'*W*Dx-Dy'*W*Dy);
    u_kp1 = A\(Wd*b);
end