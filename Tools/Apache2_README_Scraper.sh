#!/bin/bash
# Apache2 README image scraper tool
# Douglas Berdeaux 
# WeakNetLabs@Gmail.com
# A CTF tool for analysis of all \.GIF files represented by the README default file in Apache2.
# Requires two arguments, 1: to the README file, 2: to the ./icons directory on the server
#
URL = $1 # README FILE
URLNOREADME = $2 # strip off the "README" at the end, but leave the trailing slash
curl -s $1 | grep \.gif README |grep -v Identi | sed -r 's/\s+//g' \
 | sed -r 's/(,|\.\.\.)/\n/g' | sort -u \
 | xargs -I {} wget $URLNOREADME{}
