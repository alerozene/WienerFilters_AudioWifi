% Turn firewall off



%% Create a waveform and visualize it.
% data = sin(1:64);
% plot(data);
% % Create a client interface and open it.
% t = tcpip('localhost', 30000, 'NetworkRole', 'client');
% fopen(t)
% % Write the waveform to the server session.
% fwrite(t, data)
%%
tcpipClient = tcpip('127.0.0.1',55000,'NetworkRole','Client')
set(tcpipClient,'InputBufferSize',7688);
set(tcpipClient,'Timeout',30);
fopen(tcpipClient);
rawData = fread(tcpipClient,961,'double');
fclose(tcpipClient);
reshapedData = reshape(rawData,31,31);
surf(reshapedData);