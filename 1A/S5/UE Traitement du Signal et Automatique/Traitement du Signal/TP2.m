% Q1
% N = 100;
% 
% f1 = 1000;
% f2 = 3000;
% fe = 10000;
% t = (1:N)/fe;
% x = cos(2*pi*f1*t) + cos(2*pi*f2*t);
% plot(t,x)
% xlabel("t (s)");
% ylabel("A (V)");

% Q3
% N = 100;
% 
% f1 = 1000;
% f2 = 3000;
% fe = 10000;
% f = (0:N-1)*fe/N;
% t = (1:N)/fe;
% x = cos(2*pi*f1*t) + cos(2*pi*f2*t);
% semilogy(f,abs(fft(x)))
% xlabel("f (Hz)");
% ylabel("A (V)");
clear all;
close all;
clc;

N = 100;

f1 = 1000;
f2 = 3000;
fe = 10000;
f = (-N/2:N/2)*fe/N;
t = (-N/2:N/2)/fe;
x = cos(2*pi*f1*t) + cos(2*pi*f2*t);
ordre = 61;
k = (-(ordre-1)*0.5:(ordre-1)*0.5);
fc = 2000/fe;
fpb = 2*fc*sinc(2*fc*k);
y = filter(fpb,1,x);

Nfft=1024;
Yf=abs(fft(y,Nfft)).^2/max(abs(fft(y,Nfft)).^2);
Xf=abs(fft(x,Nfft)).^2/max(abs(fft(x,Nfft)).^2);
f=(0:Nfft-1)/Nfft*fe;

figure

semilogy(f,abs(fft(fpb,Nfft)).^2,'r-');
hold on;
semilogy(f,Xf,'b-');
semilogy(f,Yf,'g-')