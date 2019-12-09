% SC3011TN - Stochastische Signaal Analyse
% Matlab Assignment 2
% February 2015

%% Initialization

close all
clear all

% Load uncorrupted signal d
% N is the number of samples (signal length)
load gong.mat;
[N,~]=size(y);
d = y;

% Generate zero-mean white noise sequence g with standard deviation 0.45
sg = 0.45;
g = sg*randn(N,1);
g = g - mean(g);

% Generate noise sequences v1 and v2
a1 = [1 -0.95]; b1 = [1 -.4];
a2 = [1 -0.90]; b2 = [1 -.5];
v1 = filter(b1,a1,g);
v2 = filter(b2,a2,g);

% Generate the corrupted signal x
x = d + v1;

% You can uncomment one of the following to inspect the signals:
% plot(d); sound(d);
% plot(v1); sound(v1);
% plot(v2); sound(v2);
% plot(x); sound(x);

%% Exercise 1: Determining the optimal FIR Wiener Filter
% Goal: reconstruct d from x and v2 by estimating v1 from v2

m = input('Order filter: ');

% First we determine Rv2 and Rv1v2 needed to set up the Wiener-Hopf
% Equations:
%
%  Rv2 W = Rv1v2 (=Rxv2)
%

% Calculate the first two values of rv2 (i.e. rv2(0) and rv2(1))
% using eq (5.22) from the reader (note: variance of g is NOT 1)
% You can find the 'dimpulse' function on the TU computers
h = dimpulse(b2, a2, 2);
c(1,1) = b2*h;
c(2,1) = b2(2)*h(1);

rv2 = [a2;flip(a2)]\(sg^2*c);

% Calculate the rest of rv2 until it becomes (almost) zero
% We only determine one side of the auto-correlation function and then 
% mirror, to get the double sided ACF (centered at index 200)
for i=3:200
    rv2(i) = -a2(2)*rv2(i-1);
end
rv2_ds = [flip(rv2); rv2(2:end)];

% Next we determine the the cross-correlation function between v1 and v2
bb = conv(b1,a2);
aa = conv(a1,b2);
rv1v2_ds = filter(bb,aa,rv2_ds);

% Put rv2 and rv1v2 into matrix form for the Wiener-Hopf equations
for i = 1:m
    for j = 1:m
        Rv2(i,j) = rv2_ds(200+j-i);
    end
end
for i=1:m
    Rv1v2(i,1) = rv1v2_ds(200+i-1);
end

% Solve for the optimal filter
W = (Rv2\Rv1v2)';


%% Exercise 2: Reconstruct the signal and validate your result

% Estimate v1 by applying the filter, % and use the estimate of v1 
% to estimate d
v1e = filter(W,1,v2);
de  = x - v1e;

subplot(211)
plot([d(500:1000) x(500:1000)])
legend('Noise free sound', 'Measured sound')
axis([0 500 -1 1])

subplot(212)
plot([d(500:1000) de(500:1000)])
legend('Noise free sound', 'Reconstructed sound')
axis([0 500 -1 1])

std(d-de)

% Listen to original signal, noise-corrupted signal and reconstructed
% signal
% sound([d; x; de])


%% Exercise 3: Filter by approximating the correlation functions
% Goal: Approximate the auto- and cross correlation functions used in 
%       the Wiener-Hopf equations from the signals

m = input('Order filter: ');

rv2e    = zeros(1,m);
Rv1v2e  = zeros(m,1);

% Construct an n by (N-n+1) matrix V2 containing shifted versions of v2
V2 = zeros(m, N-m+1);
for i=1:m
    V2(i,:) = v2(i:N-m+i);
%     X(i,:) = x(i:N-m+i);  % Alternative method
end

% Use V2 and x to estimate Rv2 and Rv1v2
Rv2e = 1/(N-m)*(V2*V2');
Rv1v2e = 1/(N-m)*flipud(V2)*x(m:N);
% Rv1v2e = 1/(N-m)*X*v2(1:N-m+1);   % Alternative method using X

% % Alternative solution:
% for tau = 1:m
%     rv2e(1,tau) = 1/(N-tau)*v2(tau:N)'*v2(1:N-tau+1);
%     Rv1v2e(tau,1) = 1/(N-tau)*x(tau:N)'*v2(1:N-tau+1);
% end
% 
% Rv2e = toeplitz(rv2e);

% Calculate filter using Wiener-Hopf equations and reconstruct the signal
w = Rv2e\Rv1v2e;
v1e = filter(w,1,v2);
de = x-v1e;

subplot(211);
plot([d(500:1000) x(500:1000)]);
legend('Noise free sound','Measured sound');
axis([0 500 -1 1]);

subplot(212);
plot([d(500:1000) de(500:1000)]);
legend('Noise free sound','Reconstructed sound');
axis([0 500 -1 1]);

std(d-de)


%% Exercise 4

% Listen to original signal, noise-corrupted signal and reconstructed
% signal
% sound([d; x; de])