function [x,y] = iteration(x,y,Fx,Fy,gamma,A)
    x1 = round(x);
    y1 = round(y);
    ind = sub2ind([max(x1),max(y1)],x1,y1);
    Bx = -gamma*Fx(ind);
    By = -gamma*Fy(ind);
    x = A*x + Bx;
    y = A*y + By;
end