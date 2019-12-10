% Send audio file in form of pwm signal. Matlab needs to be connected to an
% arduino, and must have the arduino support package installed as well.
% Arduino must be connected to xdrf-5v emitter module.
% See also:
% 
% xdrf_receiver.m xdrf_pulsein.ino

% Arduino board declaration
% Select DATA pin
PIN = 'D11';                                                                % pin ocnnected to DATA on emitter
ard = arduino('com7','uno');                                                % check com port on device manager. Also check arduino board model

%% Audio file and noise signal 
% Read audio file
[audio_signal,Fs] = audioread('sound.oga');
% Make audio mono channel
audio_signal = audio_signal(:,1);
% Downsample the file
audio_signal = downsample(audio_signal,10);
% Change sampling frequency
Fs = Fs/10;
% Take only a few seconds of signal 
audio_signal = audio_signal(1e5:1.5e5); 
% sound(audio_signal)

% Make audio signal fully positive and convert to PWM
audio_pwm = audio_signal+0.5;
audio_pwm = audio_pwm*5;

%% Attempt sending audio signal with prior zeros vector and post zeros
clear ii
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