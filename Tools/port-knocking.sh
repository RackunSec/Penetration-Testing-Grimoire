#!/bin/bash
# Simple Port Knocker Script
# 2018 Douglas Berdeaux
# WeakNetLabs.com
# reference: https://highon.coffee/blog/fartknocker-walkthrough/
# 0. run enumeration scan `nmap -p 0-65535 (taregt ip address)`
# 1. run this script, give IP address and CSV of ports
# 2. run `nmap -T INSANE (target ip address)` to see if new ports opened up. 
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
