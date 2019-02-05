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
If we happen to find a service that supports the SMB protocol on the target system, we can use the cheat sheet to attempt to enumerate information from the target system.
* [SMB Cheat Sheet](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/tree/master/Enumeration/SMB)

## SNMP
If we happen to find a service that supports SNMP on the target system, we can use the cheat sheet to attempt to enumerate information from the target system.
* [SNMP Cheat Sheet](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/snmp.md)

## Web Services
Web services are often the entry point for the initial foothold on a lot of CTF and pen test exercises. Below are some steps to help enumerate information about a service or host using discovered web services.
* Check robots.txt
* Check all login pages/forms using default credentials, admin:admin, admin:password, administrator:password, etc
* [Complete HTTP Enumeration](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/HTTP/http-enumeration.md)
* [Fuzzing Cookies](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/HTTP/fuzzing-cookies.md)
* [Wordpress Enumeration](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/HTTP/wordpress-cms.md)
### Custom Tools
Below are custom tool sthat I built that come with the Grimoire project package. These can be used to test web services.
* [Tool - Brute Force Files](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/bf-files-http.sh)
* [Tool - Brute for POST usernames](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/bf-http-post-usernames.sh)
* [Tool - Brute Force HTTP Extensions](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/http-ext-test.sh)
* [Tool - Brute Force PHP pages](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/php-get-bf.sh)
* [Tool - Robots.txt.sh](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/robots.txt.test.sh)
