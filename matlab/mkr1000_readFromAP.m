% Read audio from web server on the mkr1000 board. Connect directly to the
% server. This model uses only one arduino mkr1000 board
% See also:
% mkr1000_apserver.ino

% specify IP address of the board
ipadd = 'http://192.168.1.1';
% Request data
audio_data=webread('http://192.168.1.1');