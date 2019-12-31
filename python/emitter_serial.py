# -*- coding: utf-8 -*-
"""
Created on Wed Dec 18 15:37:28 2019
Load data via serial to micro-controller board. 

@author: arozenevallesp
"""

import numpy
import serial
# Manually import tools from serial to avoid errors
import serial.tools.list_ports 
#for exiting the script in case of exceptions
import sys         

#%% Find port of the Arduino

#list ports
lstports = list( serial.tools.list_ports.comports() )
#create an empty port number
port_nr = ''

#find the port with arduino on its name
for n in lstports:
        if n.description.startswith( "Arduino" ):
            # port name of the arduino prort
            port_nr = n.device

#if no ports are found, exit the program
if port_nr == '':
    sys.exit("device not connected or not recognized")
# alternative way of declaring
# pp = [lstports[i].device for i in range(len(lstports)) if lstports[i].description.startswith("Arduino")]

#%% Create serial object
try:
    serialPort = serial.Serial(port_nr, 9600, timeout=0, rtscts=True)
except serial.serialutil.SerialException:
    serialPort.close()
    serialPort.open()

#%% Generate random data to send to serial. Adapt it to protocol

# seed 
numpy.random.seed(1)
# Array with random numbers
values = numpy.random.rand(100)
values = numpy.around(values, decimals=2)
values = values.astype('|S5')
values = [x+b'\n' for x in values]

#%% Send data to serial port

try:
    serialPort.close()    
except serial.serialutil.SerialException:
    serialPort.open()
    serialPort.close()

for x in range(len(values)): 
    serialPort.open()
    serialPort.write(values[x])
    serialPort.close()