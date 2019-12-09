% Test communication between two arduinos using RF transmission kit. Send
% digital pulses on the transmitter and read them on the receiver. If code
% is working it should display two lines (made out of points) at 0 and 3.9

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://nl.mathworks.com/help/supportpkg/arduinoio/ref/arduino.html
% Port and board https://nl.mathworks.com/help/supportpkg/arduinoio/ug/find-arduino-port-on-windows-mac-and-linux.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Arduino boards declaration 
ard = arduino('com7','uno');     % Transmitter
% I do not use the second board from matlab in this example
%ard2 = arduino('com12','micro'); % Receiver
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



%% DO NOT FORGET TO CHANGE PINS TO 

clf
figure(1)
t = 1;
vec = zeros(length(audio_signal),1);
while t<length(vec)
    % Convert double to PWM and send from Arduino board 1
    writePWMVoltage(ard, 12, audio_signal(t,1));
    
end

%%
while 1
    x=serial('COM11','BAUD', 9600);
    fopen(x);
    fscanf(x)
end


