# -*- coding: utf-8 -*-
"""
Created on Wed Dec 18 15:37:28 2019
Read simple serial data

@author: arozenevallesp
"""
import serial

"""
#Of course, this works for reading serial data
serialPort = serial.Serial(port= 'COM11', '9600', timeout=0, rtscts=True)
serialPort.inWaiting()
x = serialPort.read().decode("utf-8")
print(x)

# List serial ports, in the description, arduino mkr1000 is indicated
from serial.tools import list_ports
x = list(list_ports.comports())
print(x)



"""

serialPort = serial.Serial('COM11', 9600, timeout=0, rtscts=True)
serialPort.write(b'Send stuff\n')
serialPort.close


