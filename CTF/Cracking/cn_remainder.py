#!/usr/bin/env python3
##
# Script for PicoCTF Weird RSA challenge
# Created by Amos (LFlare) Ng
#
# Updated by Douglas Berdeaux for CTF Tools in Pentest Grimoire
# 2018 WeakNetLabs@gmail.com
#

import binascii

c = input("Give me c: ")
p = input("Give me p: ")
q = input("Give me q: ")
dp= input("Give me dp: ")
dq = input("Give me dq: ")

# Calculate qInv
qinv = (1/q) % p

# Calculate message
m2 = pow(c, dq, q)

# Convert int message to string
message = binascii.unhexlify(format(m2, 'x')).decode()

print(message)
