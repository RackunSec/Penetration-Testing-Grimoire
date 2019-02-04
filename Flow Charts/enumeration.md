# Enumeration Flow Chart
This document can be used as a reference during the enumeration pahse of the penetration test.
## NMAP
#### 1. Default Scan
Perform an NMAP scan of the system. Start with the non-verbose settings and crawl along the default search like so,
```
root@attacker-machine:~# nmap -r -vv (TARGET IP ADDRESS)
```
#### 2. All Ports Scan
Next, whiel moving on to ther tasks, run an all-ports scan in the background as so,
```
root@attaker-machine:~# nmap -r -vv -p1-65535 (TARGET IP ADDRESS)
```
#### 3. For all Discovered Ports, run Default Scripts
Finally, we want to enumerate the services on the enumerated open ports like so,
```
root@attacker-machine:~# nmap -vv -r -sV -sC -p (CSV OF PORTS) (TARGET IP ADDRESS)
```
#### 4. UDP Scan if No Results
If we happne to find no results, we can turn to a UDP scan with NMAP like so,
```
root@attacker-machine:~# nmap -r -vv -sU (TARGET IP ADDRESS)
```
## SMB
If we happnen to find a service that supports the SMB protocol on the target system, we can use the cheat sheet to attempt to enumerate information from the target system.
* [SMB Cheat Sheet](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/tree/master/Enumeration/SMB)

## SNMP
If we happnen to find a service that supports SNMP on the target system, we can use the cheat sheet to attempt to enumerate information from the target system.
* [SNMP Cheat Sheet](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/snmp.md)
