# Initial Host Discovery and Fingerprint Scans
This cheat sheet should be used as a guidline for host discovery and sevice fingerprinting during the penetratino tests.
## Host Scan / Discovery Methodology
Below are the enumeration steps that should be taken on every system during the penetration test. These steps can be adjusted according to the penetration test type, black box/etc.
### Scan the device for services:
1. [__Nmap__](https://nmap.org/) with service enumeration enabled.
### Scan for shares and WINDOWS data:
1. [__NBTScan__](http://www.unixwiz.net/tools/nbtscan.html) look for open shares on the target 
2. [__Enum4Linux__](https://github.com/portcullislabs/enum4linux) look for data from Windows hosts and LINUX Samaba hosts
### Web Services / Apps
1. [__Nikto__](https://cirt.net/Nikto2) scan for vulnerabilities
2. Browse to them and poke around for vulnerabilities
  * Use Developer Tools in Chrome or Firefox
  * Use BURP Suite Community Edition for input data analysis
3. [__SQLMap__](https://github.com/sqlmapproject/sqlmap) scan if any GET or POST input was found in the manual tests
## Service Enumeration and Fingerprinting
This section of this module will focus on the service scanning and techniques on how to get service information to be used for vulnerability analysis on the target system.
### NMAP
Initial `nmap` scan should be done without specifying a port range but adding service fingerprinting as,

`nmap -A (TARGET IP ADDRESS)`

This type of scan takes a considerable amount of time to complete. If it's moving terribly slow, I recommend doing the scan without the service fingerprinting and then performing the scan per port as you search for vulnerabilities. A full port scan, which could take hours depending on the network bandwidth and responses from the target system, can be done with the following `nmap` command,

`nmap -A -p 0-65535 (TARGET IP ADDRESS)`
