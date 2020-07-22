# NMAP Port Scanning
This module will cover some of the basics used while perfoming typical remotely accessible service enumeration on a target system. The [NMAP](https://nmap.org) tool should be one of the very first tools used during a penetration test for either discovering systems or services running on systems.

## Initial TCP Port Scan
The Initial `nmap` TCP scan should be done without specifying a port range or service fingerprinting simply as,

`nmap -vv (TARGET IP ADDRESS) -sC -sV -A -p 1-65535`

This type of scan takes a considerable amount of time to complete depending on the bandwith of the network and responses from the target system. It will scan every single port from 1 to 65,535 which is a lot of requests. The `-vv` increases the verbosity which causes `nmap` to output open ports as they are found rather than waiting all the way until the end of the scan. This way you can perform further fingerprinting and investigation to the target system concurrently during the `nmap` scan.

## Initial UDP Port Scan
Next, we want to also do a scan for opened UDP ports and we do so as,
```
root@attacker-machine:~# nmap -sU -sV -A -vv (TARGET IP ADDRESS)
```
Never forget to do a simple UDP port scan as you might miss some services that could lead you to the flag or a successful pentest much faster.

## Specifying Ports
Nmap allows us to specify single, multiple, or ranges of port(s) to scan. Knowning what ports that we want to discover will make the scanning and service enumeration process faster and more efficient. 

Single port scan:

`nmap -A -p 80 (TARGET IP ADDRESS)`

Multiple port scan:

`nmap -A -p 80,8080,443 (TARGET IP ADDRESS)`

Port range scan:

`nmap -p 80-443 (TARGET IP ADDRESS)`

## Single Service Enumeration Scan
This scan can be done on a single port in attempt to enumerate what service is runnign on that port.

`nmap -A -p (PORT NUMBER) (TARGET IP ADDRESS)`

## Full Service Enumeration Scan (slow)
A full port scan, which could take hours depending on the network bandwidth and responses from the target system, can be done with the following `nmap` command,

`nmap -A -p 0-65535 (TARGET IP ADDRESS)`
