# NMAP Port Scanning
This module will cover some of the basics used while perfoming typical remotely accessible service enumeration on a target system. The [NMAP](https://nmap.org) tool should be one of the very first tools used during a penetration test for either discovering systems or services running on systems.

## Initial Port Scan
The Initial `nmap` scan should be done without specifying a port range or service fingerprinting simply as,

`nmap (TARGET IP ADDRESS)`

This type of scan takes a considerable amount of time to complete depending on the bandwith of the network and responses from the target system. 

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
