% Receive incoming transmission from arduino connected to the receiver
% with the xdrf_pulsein.ino code loaded. Read from serial
%  See also:
% 
% xdrf_pulsein.ino, xdrf_emitter.m


%% Read from serial 
s = serialport('COM7',9600);
% check bytes available
s.NumBytesAvailable

%% 
clear ii
% vector for signal
dsplayit = zeros(1e4,1);
ii =1;
while ii<length(dsplayit)
    % Read one line of serial
    dataraw = readline(s);
    % format to double
    datpoint = str2double(dataraw);
    % store in vector
    dsplayit(ii,1)=datpoint;
    ii = ii+1;
end 
%%
% Map signal back (5V = 2e3 us)
sig = dsplayit;
% Convert from us to V
volt_raw = sig.*5/2e3;
% scale down to audio format
volt_off = volt_raw./5;
% mirror around 0
audiosignal = volt_off-0.5;
% Filter
freqdom = fft(audiosignal);
freqdom(abs(freqdom(:))>15)=0;
audioproc = ifft(freqdom);


