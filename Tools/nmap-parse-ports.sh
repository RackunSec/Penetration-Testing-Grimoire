#!/bin/bash
# NMAP output to CSV for ports script
# Douglas Berdeaux
IFS=$'\n'
if [ $1 ]; then
 for line in $(cat $1);
  do
   output=$output$(echo $line | sed -r -e 's/\/.*//')",";
 done;
fi
output=${output::-1} # Bash 4.2+ - Remove trailing comma/byte
echo "$output" # add a newline.
