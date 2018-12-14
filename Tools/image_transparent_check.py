#!/usr/bin/env python
#
# 2018 WeakNet Labs
# Douglas Berdeaux
#
# Check the transparency of a file
# For PoC of Google Chrome Extention Malware Presentation
#
from PIL import Image
import sys # for arguments and exit()

if(len(sys.argv)<2):
 print "[*] Usage: ./img_check.py (PATH/TO/IMAGE)"
 sys.exit()

sys.argv # used for argument

im = Image.open(sys.argv[1]) # open the image from argument
pix = im.load() # load the image

pic_size = im.size # get size as array

for i in range(0,pic_size[0]): # crawl through row 1paat
        for j in range(0,pic_size[1]): # crawl down columns 1paat
                pixel = pix[i,j]
                if(pixel[3]!=0):
                        print "[!] Image is not transparent."
                        sys.exit()
print "[*] Image is transparent."
