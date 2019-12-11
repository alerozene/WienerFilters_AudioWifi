
%% Accept a connection from any machine on port 30000.
% t = tcpip('0.0.0.0', 30000, 'NetworkRole', 'server');
% % Open a connection. This will not return until a connection is received.
% fopen(t);
% % Read the waveform and confirm it visually by plotting it.
% data = fread(t, t.BytesAvailable);
% plot(data);

data = membrane(1);
s = whos('data')
s.size
s.bytes
tcpipServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
set(tcpipServer,'OutputBufferSize',s.bytes);
fopen(tcpipServer);
fwrite(tcpipServer,data(:),'double');
fclose(tcpipServer);