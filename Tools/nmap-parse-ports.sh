#!/bin/bash
# NMAP output to CSV for ports script
# Douglas Berdeaux
# Description: Take $(nmap -vv $TARGETIP) style output and turn it into a CSV
#  Usefule for when doing an $(nmap -p n-m -vv $TARGETIP) type of scan
#
IFS=$'\n'
usage () {
 echo "Usage: ./nmap-parse-output.txt (filename of NMAP init file)"
 echo "  See Tools.md in repo for more information."
}
if [ $1 ]; then
 for line in $(cat $1);
  do
   output=$output$(echo $line | sed -r -e 's/\/.*//')",";
 done;
 output=${output::-1} # Bash 4.2+ - Remove trailing comma/byte
 echo "$output" # add a newline.
else
 usage
fi
