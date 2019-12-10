% Test communication between two arduinos using RF transmission kit. Send
% digital pulses on the transmitter and read them on the receiver. If code
% is working it should display two lines (made out of points) at 0 and 3.9

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://nl.mathworks.com/help/supportpkg/arduinoio/ref/arduino.html
% Port and board https://nl.mathworks.com/help/supportpkg/arduinoio/ug/find-arduino-port-on-windows-mac-and-linux.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Arduino boards declaration
PIN = 'D11';
ard = arduino('com7','uno');     % Transmitter
% I do not use the second board from matlab in this example
%ard2 = arduino('com12','micro'); % Receiver
%% Audio file and noise signal 
% Read audio file
[audio_signal,Fs] = audioread('sound.oga');
% Make mono channel
audio_signal = audio_signal(:,1);
% Downsample the file
audio_signal = downsample(audio_signal,10);
Fs = Fs/10;
% Take only a few seconds
audio_signal = audio_signal(1e5:1.5e5); 
% sound(audio_signal)
% noise amplification factor (increases the level of noise)
nfact = 1/10;
% White noise signal
noise_part = nfact*(min(audio_signal) + (abs(min(audio_signal))...
    + max(audio_signal))*rand(size(audio_signal,1),1));



% % DO NOT FORGET TO CHANGE PINS TO 



%% Send h-l for testing
% simplify audio signal by... getting rid of decimals
%audio_send = round(audio_signal,2);
audio_send = round(audio_signal,3);
audio_send = (audio_send+.4);
bin_send = upsample(audio_send,2);

%% create audio for next section
audio_pwm = audio_signal+0.5;
audio_pwm = audio_pwm*5;
   
%% Send audio perse
clear ii ind
ii = 0;
ind = 1;

while 1
    while ii <1000
            writePWMVoltage(ard,PIN,0)
            ii=ii+1;
    end
        
    if t<length(audio_signal)
        writePWMVoltage(ard,PIN,audio_pwm(ind,1));
        ind = ind+1;
        
    else
        writePWMVoltage(ard,PIN,0);
    end
end

%%
while 1
    writeDigitalPin(ard,PIN,1);
    pause(1.5)
    writeDigitalPin(ard,PIN,0);
    pause(2)
    
%         writePWMVoltage(ard,PIN,5);
    
end
        
        
