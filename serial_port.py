import serial
import time
import sys
import os

if len(sys.argv)!=3:
    print("Usage: serial_port.exe COMx AT_cmd")
    exit(0)

#convert sys.argv to bytes string
argvb = list(map(os.fsencode, sys.argv))

#Open serial port
ser=serial.Serial(sys.argv[1],115200,timeout=0.5)
#Clear buffer
ser.reset_input_buffer()

#ser.write(b"at\r\n")
ser.write(argvb[2])
ser.write(b"\r\n")
time.sleep(0.5)

#Read output data
in_byte_size = ser.in_waiting
#print(in_byte_size)
output = ser.read(in_byte_size)
output = output.decode('utf-8')
print(output)

#Close serial port
ser.close()

