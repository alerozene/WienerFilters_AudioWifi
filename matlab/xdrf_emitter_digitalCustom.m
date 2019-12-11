


close all; clear all; clc

ard = arduino('com7','uno');     % Transmitter


%% Audio file and noise signal 
% Read audio file
[audio_signal,Fs] = audioread('sound.oga');
% Make mono channel
audio_signal = audio_signal(:,1);
% Downsample the file
smplfact = 5;
audio_signal = downsample(audio_signal,smplfact);
Fs = Fs/smplfact;
% Take only a few seconds
audio_signal = audio_signal(1e5:1.5e5); 

% define a factor to make signal fully positive
signfact = .5;
% make signal binary 
audio_signal=(audio_signal+signfact).*100;
audio_bin = dec2bin(audio_signal);
binsend = audio_bin(:);
binsend = str2double(binsend);
audio_back = bin2dec(audio_bin);
tic
for ii=1:1:length(binsend)/1000
    writeDigitalPin(ard,'D11',binsend(ii));
end
ends = toc;

