# Initial Host Discovery and Fingerprint Scans
This cheat sheet should be used as a guidline for host discovery and sevice fingerprinting during the penetratino tests.
## Host Scan / Discovery Methodology
Below are the enumeration steps that should be taken on every system during the penetration test. These steps can be adjusted according to the penetration test type, black box/etc.
1. __Nmap__ the target with service enumeration enabled.
2. __Nikto__ the target if there was an open HTTP/HTTPS service
3. ...
## Service Enumeration and Fingerprinting
This section of this module will focus on the service scanning and techniques on how to get service information to be used for vulnerability analysis on the target system.
### NMAP
Initial `nmap` scan should be done without specifying a port range but adding service fingerprinting as,

`nmap -A (target IP address)`

This type of scan takes a considerable amount of time to complete.
