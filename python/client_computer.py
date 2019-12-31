# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import serial
import time 
try:
    s = serial.Serial('COM3', 9600, timeout=0, rtscts=True)
    
except serial.serialutil.SerialException:
    s.close()
    s.open()

#%%
#Modified code from thread reading the serial port
lst = []
s.close()
s.open()
while 1:
  tdata = s.readline().decode("utf-8")
  if tdata != '':
      print(tdata)
      lst.append(tdata)
  #time.sleep(0.00001)
  #print(tdata)
  #lst.append(tdata)
  if tdata == 'finito\r\n':
      break
  
  


"""
  lst = []
  for ii in range (0,5):
      a = str(ii)
      lst.append(a)
"""