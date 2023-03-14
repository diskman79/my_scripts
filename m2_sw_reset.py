import serial
ser=serial.Serial("com3",115200,timeout=0.5)
ser.write(b"at+log=29,1\r\n")
ser.close()

