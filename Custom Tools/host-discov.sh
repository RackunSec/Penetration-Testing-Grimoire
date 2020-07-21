#!/bin/bash
# 2019 WeakNet Labs, Douglas Berdeaux
# Host discovery script
usage () {
 printf "[!] Pass to me the first octets of the IP and the range of the final.\n"
 printf "[!] ./host-discov.sh 192.168.1 1-255 # will scan 129.168.1.1-255\n"
 exit
}
first3Octs=$1 # first three octets
range=$(echo $2|sed 's/-/ /g')
if [[ "$range" == "" ]] # need to pass an argument.
 then
  usage;
fi # okay go:
printf "[*] Got ${first3Octs} - ${range}\n";
for oct in $(seq $range); do # "is alive." like the old days of Sun <3
 ping -c 1 ${first3Octs}.${oct} &>/dev/null && printf "[*] ${first3Octs}.${oct} is alive.\n"
done
