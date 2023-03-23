function u_kp1 = debruitage(b,u_k,lambda,Dx,Dy,epsilon)
    N = length(b);
    W = spdiags( 1 ./ sqrt( (Dx*u_k).^2 + (Dy*u_k).^2 + epsilon), 0, N, N);
    A = speye(N) - lambda*(-Dx'*W*Dx-Dy'*W*Dy);
    u_kp1 = A\b;
end