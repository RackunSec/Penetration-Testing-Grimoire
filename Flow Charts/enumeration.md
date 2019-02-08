## Enumeration Flow Chart
This document can be used as a reference during the enumeration pahse of the penetration test.
## OS and Service Enumeration
### NMAP
The very first thingh that we do for eunerating a target's potentially vulnerable services is to run a full NMAP scan on the target. 
* [Complete NMAP Service Enumeration](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/nmap-port-scanning.md)

### ICMP
We can use ICMP for host discovery and OS enumeration in some cases.
* [Full ICMP Enumertaion](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/icmp.md)

### SMB
If we happen to find a service that supports the SMB protocol on the target system, we can use the cheat sheet to attempt to enumerate information from the target system.
* [Complete SMB Enumeration](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/tree/master/Enumeration/SMB)

### SNMP
If we happen to find a service that supports SNMP on the target system, we can use the cheat sheet to attempt to enumerate information from the target system.
* [Complete SNMP Enumeration](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/snmp.md)

### DNS
Often times, if DNS is running on port 53, you can gather additional information from nameservers, find new websites via virtual hosting and much more. This sheet will offer syntax that you can use to utilize a DNS service on a target host.
* [Complete DNS Enumeration](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/dns-service.md)

### Web Services
Web services are often the entry point for the initial foothold on a lot of CTF and pen test exercises. Below are some steps to help enumerate information about a service or host using discovered web services.
* Check robots.txt
* Check all login pages/forms using default credentials, admin:admin, admin:password, administrator:password, etc
* Run Nikto.pl against the service
* Run DIRB against the service with multiple extensions, using multiple wordlists
* Check for administrative pages of Java/Coldfusion/Tomcat/ etc
* Check all input areas for sanitation and validation, SQL Injection, Command Injection, LFI, RFI, etc
* [Complete HTTP Enumeration](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/HTTP/http-enumeration.md)
* [Fuzzing Cookies](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/HTTP/fuzzing-cookies.md)
* [Wordpress Enumeration](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/HTTP/wordpress-cms.md)
#### Custom Tools
Below are custom tool sthat I built that come with the Grimoire project package. These can be used to test web services.
* [Tool - Brute Force Files](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/bf-files-http.sh)
* [Tool - Brute for POST usernames](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/bf-http-post-usernames.sh)
* [Tool - Brute Force HTTP Extensions](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/http-ext-test.sh)
* [Tool - Brute Force PHP pages](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/php-get-bf.sh)
* [Tool - Robots.txt.sh](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/robots.txt.test.sh)

## 
