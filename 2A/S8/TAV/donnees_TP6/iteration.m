function [x,y] = iteration(x,y,Fx,Fy,gamma,A)
    ind = sub2ind(size(Fx),round(y),round(x));
    x = A*x - gamma*Fx(ind);
    y = A*y - gamma*Fy(ind);
end