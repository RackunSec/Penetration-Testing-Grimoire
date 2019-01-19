# SNMP Enumeration
We can enumerate SNMP by trying to figure out the community or passphrase of the service which, by default anyways, is often running on port `161`. We use the default "community string" of "public" as a first attempt for `snmpwalk` enumeration.
## SNMPWalk
We can use `snmpwalk` with the following syntax to enumerate any information from the target server.
### Version 1
```
root@attacker-machine:~# snmpwalk -c public (TARGET IP ADDRESS) -v1 -On
.1.3.6.1.2.1.47.1.1.1.1.11 = STRING: "DATA WILL BE HERE"
End of MIB
```
### Version 2c
This is the most commonly used version as the time of writing this document.
```
root@attacker-machine:~# snmpwalk -c pubic -v2c (TARGET IP ADDRESS)
```
### Version 3
You can also use `snmpwalk` with SNMP Version 3, but version 3 does not have an "easily guessable" or default community string.
## OneSixtyOne
Another great tool for SNMP service enumeration is [OneSixtyOne](https://github.com/trailofbits/onesixtyone)
```
root@attacker-machine:~# git clone https://github.com/trailofbits/onesixtyone && cd onesixtyone
root@attacker-machine:~# make
root@attacker-machine:~# ./onesixtyone -c /pwnt/passwords/wordlists/SecLists/Discovery/SNMP/snmp.txt (TARGET IP ADDRESS)
scanning 1 hosts, 122 communities
(TARGET IP ADDRESS) [communityStringName] Linux (TARGET HOSTNAME) (TARGET KERNEL UNAME) 
```
As you can see, it returned the SNMP community string of "communityStringName" that we can use to get more information.
