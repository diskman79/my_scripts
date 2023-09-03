import os
import random


#path = "."
files = os.listdir(".")
oldname = ""
newname = ""
random_num = 0

for file in files:
    if not os.path.isdir(file):
        random_num = random.randrange(1000)
        oldname = file
        newname = str(random_num).zfill(3) + " " + file
        os.rename(oldname, newname)


        
