import serial
import time

ser=serial.Serial("/dev/ttyUSB0",9600,timeout=0.5)
input = b"\xA0\x01\x01\xA2"
ser.write(input)
time.sleep(1)
input = b"\xA0\x01\x00\xA1"
ser.write(input)
ser.close()