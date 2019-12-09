% Test communication between two arduinos using RF transmission kit. Send
% digital pulses on the transmitter and read them on the receiver. If code
% is working it should display two lines (made out of points) at 0 and 3.9

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://nl.mathworks.com/help/supportpkg/arduinoio/ref/arduino.html
% Port and board https://nl.mathworks.com/help/supportpkg/arduinoio/ug/find-arduino-port-on-windows-mac-and-linux.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Arduino boards declaration 
ard = arduino('com7','uno');     % Transmitter
ard2 = arduino('com12','micro'); % Receiver
%% Audio file and noise signal 
% Read audio file
[audio_signal,Fs] = audioread('sound.oga');
% Make mono channel
audio_signal = audio_signal(:,1);
% Downsample the file
audio_signal = downsample(audio_signal,5);
% Take only a few seconds
audio_signal = audio_signal(1e5:1.5e5); 
% sound(audio_signal)
% noise amplification factor (increases the level of noise)
nfact = 1/10;
% White noise signal
noise_part = nfact*(min(audio_signal) + (abs(min(audio_signal))...
    + max(audio_signal))*rand(size(audio_signal,1),1));
%%

% modu = fmmod(audio_signal,1e1,Fs,10);
% modu = 1+ modu
% dmodu = fmdemod(modu,1e1,Fs,10);



% % DO NOT FORGET TO CHANGE PINS TO 

clf
figure(1)
t = 0;
vec = zeros(1e3,1);
while 1
    
    playTone(ard,'D3',100,10);
    a = readVoltage(ard2,'A5');
    vec(t+1,1) = a;
    plot(t,a,'-o')
    t = t+1;
    
end
%% whos
x=serial('COM12','BAUD', 9600);
fopen(x);
fprintf(x,0)

