import serial
import time

ser=serial.Serial("com6",9600,timeout=0.5)
input = b"\xA0\x01\x01\xA2"    
ser.write(input)
time.sleep( 3 )
input = b"\xA0\x01\x00\xA1"    
ser.write(input)
ser.close()

