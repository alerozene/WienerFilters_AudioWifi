% Send audio file to thingspeak channel

%% Audio file and noise signal 
% Read audio file
[audio_signal,Fs] = audioread('sound.oga');
% Make audio mono channel
audio_signal = audio_signal(:,1);

% Parameters for the thingspeak channel (check the website)
channelID =  935110;
writeKey = 'S6BNB1NZ6MKPGTR9';

% Time vector to relate to audio file
tStamps = datetime('now','InputFormat','MM/dd/uuuu HH:mm:ss:ms')-...
    seconds(2001):seconds(1):datetime('now','InputFormat','MM/dd/uuuu HH:mm:ss:ms'); 
tStamps(length(tStamps)) = [];

% Write audio file to thingspeak channel
thingSpeakWrite(channelID,audio_signal,'TimeStamp',tStamps,'WriteKey',writeKey);