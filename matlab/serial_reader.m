
% Create serial object with baudrate 9600. Check port via Windows>Device
% manager>SerialPort
s = serialport('COM6',9600);

% Read data in packets of 60 bytes
data = read(s,60,"uint8");
bufferredstuff = s.NumBytesAvailable;

% https://nl.mathworks.com/help/matlab/matlab_external/serial-port-overview.html
% End serial comm
delete(s)
clear s