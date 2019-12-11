
%% Write data to serial
s = serialport('COM3',9600);
s.NumBytesAvailable
%%
while 1
    write(s,1:8,"uint8");
end
%% yet another approach (this one works, yet i disgree with values)
clear ii
dsplayit = zeros(1e4,1);
ii =1;
while 1
    dataraw = readline(s);
    datpoint = str2double(dataraw);
    dsplayit(ii,1)=datpoint;
    ii=ii+1;
    if ii==length(dsplayit)
        plot(dsplayit)
        ii=1;
        pause(0.001);
        dsplayit = zeros(1e6,1);
    end
end 
%% Attempt signal meas
clear ii
dsplayit = zeros(1e4,1);
ii =1;
while ii<length(dsplayit)
    dataraw = readline(s);
    dsplayit(ii,1) = str2double(dataraw);
    ii=ii+1;
   
end
%%
clear all
close all
clc
load pulse_in_signal11122019
% Map back signal 5V 2e3 us
sig = dsplayit;
volt_raw = sig.*5/2e3;
volt_off = volt_raw./5;
audiosignal = volt_off-0.5;

% Filter
freqdom = fft(audiosignal);
freqdom(abs(freqdom(:))>1)=0;
audioproc = ifft(freqdom);


