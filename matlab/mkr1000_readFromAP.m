% Read audio from web server on the mkr1000 board. Connect directly to the
% server. This model uses only one arduino mkr1000 board
% -------------------------------------------------------------------------
% Guide:
% 1. Upload mkr1000_apserver.ino to wifi board
% 2. On a computer with wifi, connect to network "wifimkr"
% 3. Run this matlab code on that computer
% 
% See also:
% mkr1000_apserver.ino

% specify IP address of the board
ipadd = 'http://192.168.1.1';
% Request data
audio_data=webread('http://192.168.1.1');
% Process data and plot
audio_signal = str2num(audio_data);
sigstrength = audio_signal(length(audio_signal))
audio_signal(length(audio_signal)) =[];
plot(audio_signal)
sound(audio_signal,1000)
