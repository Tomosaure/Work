function X = moindres_carres_ponderes(D_app,probas)
    n_app = size(D_app,2);
    O = [zeros(n_app,1) ; 1];
    X = D_app(1,:)';
    Y = D_app(2,:)';
    A = [X.^2 X.*Y Y.^2 X Y ones(n_app,1)];
    A = [A.*probas' ; 1 0 1 0 0 0];
    X = A\O;
end