function A = matrice_A(N,alpha,beta,gamma)
 diag = ones(N,1);
 D = spdiags([diag -2*diag diag],-1:1,N,N);
 D(1,end) = 1;
 D(end,1) = 1;
 A = eye(N) + gamma*(alpha*D-beta*(D')*D);
end