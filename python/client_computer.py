# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import serial
import time 
import matplotlib.pyplot as plot
#from playsound import playsound

try:
    s = serial.Serial('COM3', 230400, timeout=0, rtscts=True)
    
except serial.serialutil.SerialException:
    s.close()
    s.open()

#%%
#Modified code from thread reading the serial port
lst = []
started = 0
s.close()
s.open()
while 1:
  tdata = s.readline().decode("utf-8")
  if tdata != '' and tdata != 'Emitter_detected\n':
      #print(tdata)
      lst.append(tdata)
      started +=1
      sizof = len(lst)
  if started > 500000:
      break
  
  
      
      
