# NMAP Port Scanning
This module will cover some of the basics used while perfoming typical remotely accessible service enumeration on a target system. The [NMAP](https://nmap.org) tool should be one of the very first tools used during a penetration test for either discovering systems or services running on systems.

## Initial Port Scan
The Initial `nmap` scan should be done without specifying a port range or service fingerprinting simply as,

`nmap (TARGET IP ADDRESS)`

This type of scan takes a considerable amount of time to complete depending on the bandwith of the network and responses from the target system. 

## Single Service Enumeration Scan
This scan can be done on a single port in attempt to enumerate what service is runnign on that port.

`nmap -A -p (PORT NUMBER) (TARGET IP ADDRESS)`

## Full Service Enumeration Scan (slow)
A full port scan, which could take hours depending on the network bandwidth and responses from the target system, can be done with the following `nmap` command,

`nmap -A -p 0-65535 (TARGET IP ADDRESS)`
