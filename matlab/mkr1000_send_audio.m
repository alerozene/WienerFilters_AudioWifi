
% Use serial instead of serial port. matlab<2019 doesnt support serialport
s = serial('COM11','BaudRate',9600);
audio_file = 1:60;
audio_file = uint8(audio_file);
fopen(s)
fwrite(s,audio_file,'uint8')
fclose(s)

%% This code snippet works nively with the following .ino file:
% 
% int ii= 0;//Set maximum length for message
% int maxl = 1e6;
% int incomingByte = 0;; // variable type we are expecting
% void setup() {
%   Serial.begin(9600);
% }
% void loop() { 
%   //if (Serial.available()>0 & ii<maxl){
%   if(Serial.available()>0){
%     incomingByte = Serial.read();
%     Serial.println(incomingByte, DEC);
%     //i++;
%     }
%     delay(100);
% }