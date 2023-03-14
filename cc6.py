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
    random_string = ''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(6))
    my_random_code = Prefix + random_string
##    print(my_random_code)


    hash_object = hashlib.sha256(my_random_code.encode('utf-8'))
    hash_string = hash_object.hexdigest()
##    print(hash_string)

    #hash_string.translate(string.ascii_lowercase)
    #print(hash_string)

    i = len(TargetCode)
    for c in hash_string:
        if c in string.digits:
            i=i-1
            s = s+c
        if i==0:
##            print(s)
            break



print(my_random_code)
print(hash_string)


