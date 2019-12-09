

% https://nl.mathworks.com/help/supportpkg/arduinoio/ref/arduino.html
ard = arduino('com7','uno');         % Port and board https://nl.mathworks.com/help/supportpkg/arduinoio/ug/find-arduino-port-on-windows-mac-and-linux.html
ard2 = arduino('com5','micro');

[audio_signal,Fs] = audioread('sound.oga');
audio_signal = audio_signal(:,1);
audio_signal = downsample(audio_signal,4);
sound(audio_signal)
nfact = 1/10;
noise_part = nfact*(min(audio_signal) + (abs(min(audio_signal))...
    + max(audio_signal))*rand(size(audio_signal,1),1));

