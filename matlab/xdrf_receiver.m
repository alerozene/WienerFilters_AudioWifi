% Receive incoming transmission from arduino connected to the tr receiver
% and with the xdrf_pulsein.ino code loaded
%  See also:
% 
% xdrf_pulseIn.ino, xdrf_emitter.m

% Read incoming data from emitter
ard2 = arduino('com7','micro'); % Receiver
received = zeros(1e6,1);
timer = 1;
while timer<length(received)
    received(timer,1) = readVoltage(ard2,'A5');
    timer = timer+1;
end

%% Read from serial (weird values)
s = serialport('COM7',9600);
s.NumBytesAvailable
%%
while 1
    data = read(s,1e3,"uint32");
    plot(data);
    pause(0.01);
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


