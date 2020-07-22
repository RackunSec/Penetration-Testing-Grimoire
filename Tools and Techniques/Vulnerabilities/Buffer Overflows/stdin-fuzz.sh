#!/bin/bash
# Standard In C program fuzzer
# 2019 WeakNet Labs, Douglas Berdeaux
buf="" # this will be the buffer overflow
appname=$1 # pass to me the app name
while [ 1 ]
 do
  buf+="A"
  #printf "[*] buf is now: $buf\n";
  seg=$(./${appname} $buf || echo "0x031337" | egrep "0x031337"| wc -l)
  if [[ "$seg" == "1" ]]
   then
    printf "[!] Segmentation Fault Successful! ($(echo -n $buf|wc -m)) bytes.\n"
    exit;
  fi
done;
