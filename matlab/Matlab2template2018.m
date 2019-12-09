% SC3011TN - Stochastische Signaal Analyse
% Matlab Assignment 2
% February 2015

%% Initialization

close all
clear all

% Load uncorrupted signal d
% N is the number of samples (signal length)
load gong.mat;
[N,k]=size(y);
d = y;

% Generate zero-mean white noise sequence g with standard deviation 0.35
sg = 0.45;
g = sg*randn(N,1);
g = g - mean(g);

%% Exercise 1: Generate noise sequences v1 and v2

a1 =  
b1 = 
a2 = 
b2 = 
v1 = filter(
v2 = filter(

% Generate the corrupted signal x
x = 

% You can uncomment one of the following to inspect the signals:
% plot(d); sound(d);
% plot(v1); sound(v1);
% plot(v2); sound(v2);
% plot(x); sound(x);

%% Exercise 2: Determining the optimal FIR Wiener Filter
% Goal: reconstruct d from x and v2 by estimating v1 from v2

% First we determine Rv2 and Rv1v2 needed to set up the Wiener-Hopf
% Equations:
%
%  Rv2 W = Rv1v2 (=Rxv2)
%

% Calculate the first two values of rv2 (i.e. rv2(0) and rv2(1))
% using eq (5.22) from the reader (note: variance of g is NOT 1)
% You can find the 'dimpulse' function on the TU computers
h = dimpulse(b2, a2, 2);
c(1,1) = 
c(2,1) = 

rv2 = 

% Calculate the rest of rv2 until it becomes (almost) zero
% We only determine one side of the auto-correlation function and then 
% mirror, to get the double sided ACF (centered at index 200)
for i=3:200
    rv2(i) = 
end
rv2_ds = [flip(rv2); rv2(2:end)];

% Next we determine the the cross-correlation function between v1 and v2
bb = conv(
aa = conv(
rv1v2_ds = filter(

m = input('Order filter: ');

% Put rv2 and rv1v2 into matrix form for the Wiener-Hopf equations
for i = 1:m
    for j = 1:m
        Rv2(i,j) = 
    end
end
for i=1:m
    Rv1v2(i,1) = 
end

% Solve for the optimal filter
W = 


%% Exercise 3: Reconstruct the signal and validate your result

% Estimate v1 by applying the filter, % and use the estimate of v1 
% to estimate d
v1e = filter(
de  = 

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
sound([d; x; de])


%% Exercise 4: Filter by approximating the correlation functions
% Goal: Approximate the auto- and cross correlation functions used in 
%       the Wiener-Hopf equations from the signals

m = input('Order filter: ');

% Construct an n by (N-n+1) matrix V2 containing shifted versions of v2
V2 = zeros(m, N-m+1);
for i=1:m
    V2(i,:) = 
end

% Use V2 and x to estimate Rv2 and Rv1v2
Rv2e = 
Rv1v2e = 

% Calculate filter using Wiener-Hopf equations and reconstruct the signal
w = 
v1e = filter(
de = 

subplot(211);
plot([d(500:1000) x(500:1000)]);
legend('Noise free sound','Measured sound');
axis([0 500 -1 1]);

subplot(212);
plot([d(500:1000) de(500:1000)]);
legend('Noise free sound','Reconstructed sound');
axis([0 500 -1 1]);

std(d-de)


%% Exercise 5

% Listen to original signal, noise-corrupted signal and reconstructed
% signal
sound([d; x; de])