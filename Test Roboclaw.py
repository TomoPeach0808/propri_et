import sys
from pathlib import Path
import time
file_path = f"{Path.cwd()}/Roboclaw_python_import"
sys.path.append(file_path)
from roboclaw_3 import Roboclaw


# Code starts here
roboclaw = Roboclaw("/dev/tty.usbmodem14101", 9600)
roboclaw.Open()

roboclaw.ForwardM1(0x80,5)
# time.sleep(0.12)
# roboclaw.BackwardM1(0x80,5)


# roboclaw.ForwardM1(0x80,3)


# import serial
# ser = serial.Serial("/dev/tty.usbmodem", 141101)
#
# for address in range(128):
#     ser.write(bytes([address, 21]))
#     response = ser.read(32)
#     if len(response) > 0:
#         print(f"RoboClaw found at address {address}")