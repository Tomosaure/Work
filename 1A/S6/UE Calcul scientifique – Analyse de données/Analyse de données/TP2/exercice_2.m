clear all;
close all;

load Data_Exo_2/SG1
load Data_Exo_2/ImSG1

[n, m] = size(ImMod);
[n1, m1] = size(DataMod);
A = [-Data(:) ones(n1*m1,1)];
b = log(DataMod(:));
X = pinv(A)*b;

I2 = (X(2) - log(ImMod(:)))/X(1);
I2 = reshape(I2,n,m);
imshow(I2)
RMSE = sqrt(mean(mean((I2-I).^2)));

C=[A b];
X_chapeau = [X -1]';
[U, S, V] = svd(C);