function out = moindres_carres(D_app)
    n_app = size(D_app,2);
    O = [zeros(n_app,1) ; 1];
    X = D_app(1,:)';
    Y = D_app(2,:)';
    A = [X.^2 X.*Y Y.^2 X Y ones(n_app,1) ; 1 0 1 0 0 0];
    out = A\O;
end