
retx = arduino('com7','micro'); % Receiver

%% 
figure(1)
clf
hold on
clf 
clear tim
tim = 1;
while 1
    bitsig = readDigitalPin(retx,'A5');
    plot(tim,bitsig,'ro');
    hold on
    axis([0 1e3 0 5])
    
    tim=tim+1;
    pause(1e-2)
end
    