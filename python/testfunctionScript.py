# -*- coding: utf-8 -*-
"""
Created on Wed Dec 18 15:37:28 2019
Read simple serial data

@author: arozenevallesp
"""
import serial
#import numpy

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


try:
    serialPort = serial.Serial('COM15', 9600, timeout=0, rtscts=True)
    
except serial.serialutil.SerialException:
    serialPort.close()
    serialPort.open()

serialPort.write(b'WRITE\n')
serialPort.close

"""


serialPort = serial.Serial('COM15', 9600, timeout=0, rtscts=True)
serialPort.open
serialPort.write(b'WRITE\n')
serialPort.close



# seed 
numpy.random.seed(1)
# Array with random numbers
values = numpy.random.rand(10)
values = numpy.around(values, decimals=2)
values = values.astype('|S4')



for x in numpy.nditer(values):
    print(x)
    serialPort.write(x)
    serialPort.write(b'\n')
serialPort.close

"""


