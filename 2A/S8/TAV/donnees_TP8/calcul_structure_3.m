function u_barre_new = calcul_structure_3(u_barre, u,Dx,Dy,Phi,epsilon,mu_prime,gamma)
    u_barre_reshaped = reshape(u_barre,size(u_barre,1)*size(u_barre,1),1);

    ux_barre  = Dx*u_barre_reshaped;
    uy_barre  = Dy*u_barre_reshaped;
    uxx_barre = -Dx'*Dx*u_barre_reshaped;
    uxy_barre = -Dx'*Dy*u_barre_reshaped;
    uyy_barre = -Dy'*Dy*u_barre_reshaped;

    div = uxx_barre.*(uy_barre.^2+epsilon)+uyy_barre.*(ux_barre.^2+epsilon)-2*ux_barre.*uy_barre.*uxy_barre;
    div = div./((ux_barre.^2+uy_barre.^2+epsilon).^(3/2));
    div = reshape(div,size(u));

    TF_u_barre = fftshift(fft2(u_barre));
    TF_u = fftshift(fft2(u));
    TF_inverse = real(ifft2(ifftshift(Phi.*(TF_u_barre-TF_u))));
    
    u_barre_new = u_barre - gamma*(TF_inverse-mu_prime*div);

end