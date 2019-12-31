% Test correct functionality of the xdrf-5V 433Mhz radio transmitter. Send
% a set of H-signals and check whether they form a line of points on the
% plotter

% Arduino boards declaration 
ard = arduino('com10','uno');     % Transmitter
ard2 = arduino('com7','micro'); % Receiver
%% Communicate
clf
figure(1)
t = 0;                                                                      %initialize timer

while t<1e3                                                                 %run for 1e3 instances
    writeDigitalPin(ard,'D4',1);                                        
    a = readVoltage(ard2,'A5');
    plot(t,a,'-o')
    t = t+1;
    pause(1e-6);
    writeDigitalPin(ard,'D4',0);
    a = readVoltage(ard2,'A5');
    plot(t,a,'-o')
    hold on
    axis([0 1e3 0 6])
    pause(1e-6)
    t = t+1; 
end
