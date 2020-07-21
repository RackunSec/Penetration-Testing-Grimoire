#!/bin/bash
# 2019 WeakNet Labs, Douglas Berdeaux
# Port scanner script using /dev/tcp
target=$1
range=$(echo $2| sed 's/-/ /g')
usage () {
 printf "[!] Usage: ./portscan.sh (TARGET IP ADDRESS)\n"
 exit 1;
}
if [[ "$range" == "" ]]
 then
  usage
fi # OK GO
printf "[*] Got sockets $target: $range\n";
for port in $(seq $range);
 do
 (echo $port > /dev/tcp/$target/$port && printf "[!] $port is open.\n") 2>/dev/null
done
