#!/usr/bin/python
import hashlib
import random
import string

Prefix = input("Please input your Prefix: ")
TargetCode = input("Please input your target number: ")

print(TargetCode)

s = ""
while s!=TargetCode:
    s = ""
    #Get a Random number
    my_random_code = Prefix + "%06d" % random.randint(0, 999999)
    print(my_random_code)


    hash_object = hashlib.sha256(my_random_code.encode('utf-8'))
    hash_string = hash_object.hexdigest()
    print(hash_string)

    #hash_string.translate(string.ascii_lowercase)
    #print(hash_string)

    i = 3
    for c in hash_string:
        if c in string.digits:
            i=i-1
            s = s+c
        if i==0:
            print(s)
            break


    


