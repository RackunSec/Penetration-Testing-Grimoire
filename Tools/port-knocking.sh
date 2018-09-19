#!/bin/bash
# Simple Port Knocker Script
# 2018 Douglas Berdeaux
# WeakNetLabs.com
#
function usage {
 echo "Port Knocker Script: ";
 exit 1;
}
if [[ "$1" == '-h' ]];
 then
  usage;
else
 printf "[?] Which host shall I scan? "
 read host;
 printf "[?] Which ports shall I knock? "
 read ports;
 IFS="," read -r -a portsarray <<< "$ports"
 for port in "${portsarray[@]}"
  do
   nmap -Pn --host_timeout 100 --max-retries 0 -p $port $host
  done
fi
# Provide the IP and ports as CSV when prompted.
