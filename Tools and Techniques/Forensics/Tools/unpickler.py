#!/usr/bin/python
import pickle
import sys
if len(sys.argv) < 2: # must provide a filename
 print "Please provide a pickled file to open."
 sys.exit() # exit the script
fh = open(sys.argv[1]) # create a file handle
lfh = pickle.load(fh) # load the file
outstr = '' # string to be printed
for line in lfh:
    for char,n in line:
        outstr += char*n
    outstr += '\n' # newline
print outstr
