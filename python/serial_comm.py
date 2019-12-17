# -*- coding: utf-8 -*-
"""
Read audio file, then send it over serial to an ESP32 device

NOTES:
    -Must install serial module
    -Look into pyAudio
Created on Fri Dec 13 13:56:13 2019
@author: arozenevallesp
"""

import serial
import numpy
import struct

#create serial object
ser = serial.Serial()
ser.baudrate = 115200
ser.port = 'COM14'

a = numpy.arange(1.0,100.0)
#Open port send data
if(ser.isOpen() == False):
    ser.open()

for x in range(len(a)):
    b = a[x]
    
    ser.write(0.1)
    data = ser.read(4)
    f_data, = struct.unpack('<f',data)
    print(f_data)



#
"""
#Open port send data
if(ser.isOpen() == False):
    ser.open()
"""







"""
try:
  ser = serial.Serial( # set parameters, in fact use your own :-)
    port="COM4",
    baudrate=9600,
    bytesize=serial.SEVENBITS,
    parity=serial.PARITY_EVEN,
    stopbits=serial.STOPBITS_ONE
  )
  ser.isOpen() # try to open port, if possible print message and proceed with 'while True:'
  print ("port is opened!")

except IOError: # if port is already opened, close it and open it again and print message
  ser.close()
  ser.open()
  print ("port was already open, was closed and opened again!")

while True: # do something...
"""