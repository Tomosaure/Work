% Q1
% N = 90;
% 
% fe = 10000;
% t = (1:N)/fe;
% f0 = 1100;
% x = cos(2*pi*f0*t);
% plot(x)
% xlabel("t (s)");
% ylabel("A (V)");
% 
% fe = 1000;
% t = (1:N)/fe;
% f0 = 1100;
% y = cos(2*pi*f0*t);
% hold on
% plot(y)
% xlabel("t (s)");
% ylabel("A (V)");


% Q2
% N = 90;
% 
% fe = 10000;
% t = (1:N)/fe;
% f = (0:N-1)*fe/N;
% f0 = 1100;
% x = cos(2*pi*f0*t);
% semilogy(f,abs(fft(x)))
% xlabel("f (Hz)");
% ylabel("A (V)");
% 
% fe = 1000;
% t = (1:N)/fe;
% f = (0:N-1)*fe/N;
% f0 = 1100;
% y = cos(2*pi*f0*t)
% figure
% semilogy(f,abs(fft(y)))
% xlabel("f (Hz)");
% ylabel("A (V)");

% Q3
% N = 90;
% 
% fe = 10000;
% t = (1:N)/fe;
% f = (0:N-1)*fe/N;
% f0 = 1100;
% x = cos(2*pi*f0*t);
% semilogy(f,abs(fft(x)))
% xlabel("f (Hz)");
% ylabel("A (V)");
% 
% N2 = 2^12;
% f2 = (0:N2-1)*fe/N2;
% y = fft(x,N2)
% hold on
% semilogy(f2,abs(y))

% Q4
N = 90;
fe = 10000;
t = (1:N)/fe;
f = (-N/2:N/2)*fe/N;
f0 = 1100;
y = autocorr(cos(2*pi*f0*t));
dsp = fft(y);
plot(f,dsp)
xlabel("f (Hz)");
ylabel("A (V)");

