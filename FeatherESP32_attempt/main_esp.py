
"""

@author: arozenevallesp
"""

import Audio
import time


import serial                                                                   # module for serial communication
import serial.tools.list_ports 






datasend = Audio.audiofilenew('advtime.wav',130)
datasend = Audio.adapt3(datasend,150)
ser = serial.Serial()
ser.baudrate = 500000
time.sleep(0.5)
ser.port = 'COM18'

ser.open()
flag = 0
while flag == 0:
    mesg1 = ser.readline().decode("utf-8")
    print(mesg1)
    if mesg1.startswith("Client"):
        flag = 1
        

start_time = time.time()
for x in range(len(datasend)): 
    ser.write(datasend[x])
end_time = time.time()
print(end_time - start_time)

ser.close()