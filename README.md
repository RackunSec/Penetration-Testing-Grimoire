# The Penetration Testing Grimoire
Custom Tools, Cheat Sheets, and Notes from my penetration testing experience. During my studies in labs, I decided to start making notes of these since I won't be using (all of) them on a daily basis.


### gri·moire
#### /ɡrimˈwär/
*noun*

a book of magic spells and invocations.

## [Custom-Built Tools](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/Tools.md)
These are custom scripts or tools that I whipped up during penetration testing labs, capture the flag (CTF), [VulnHUB](https://www.vulnhub.com/), and [Hack the Box](https://www.hackthebox.eu/) exercises. 
* [*Tools/Robots.txt.test.sh*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Tools/robots.txt.test.sh) - This tool will grab the robots.txt file and run through each entry to display the HTTP status of the file.
  * Run with `chmod +x robots.txt.test.sh && ./robots.txt.test.sh`
* [*Tools/ntlm-bf.sh*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Tools/ntlm-bf.sh) - This tool will loop through a text file and try every password with the username of "admin"
  * Run with `chmod +x bf.sh && ./bf.sh (URI) (PATH TO WORD LIST) (UID)`
* [*Tools/nmap-parse-ports.sh*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/nmap-parse-ports.sh) - Thi tool parses the normal `nmap -v (TARAGET IP ADDRESS)` output into a CSV for `nmap -A -p (CSV) (TARGET IP ADDRESS)` See Tools.md in that folder for full reference.
* [*Tools/php-get-bf.sh*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/php-get-bf.sh) - PHP GET parameter fuzzer / brute force tool. Simply place an asterisk, \*, where you want the fuzz.
* [*Tools/nmap-parse-ports.sh*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/nmap-parse-ports.sh) - NMAP Parse ports. Parse the output of nmap into a small CSV to re-scan using the NSE/timely scripts.
* [*Tools/Apache2-README-Scraper.sh*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/Apache2-README-Scraper.sh) - Apache2 README scraping tool. Scrape out all of the image files for local exif/stego analysis during CTF.
* [*Tools/port-knocking.sh*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/port-knocking.sh) - Port knocking sequence tool. 
* [*Tools/hex2dec.c*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/hex2dec.c) - Hex2Dec conversion tool for reverse engineering/malware anlysis, or just plain math purposes.
* [*Brute Force/Tools/drupalUserEnum.py*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/Tools/drupalUserEnum.py) - A tool that can be used to enumerate valid users of a Drupal CMS installation on the target host.
* [*Tools/opensslDecrypt.sh*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/opensslDecrypt.sh) - Crack an `.enc` openSSL encrypted text file using this simple brute-force script that I wrote.
* [*Tools/bfhttp.sh*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/bfhttp.sh) - an HTTP file enumeration tool that will ignore empty responses. 

## Cheat Sheets
These sheets should be used for quick reference during penetration tests.
### Enumeration of Services and Host Discovery
* [*Enumeration/initial_scan.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Enumeration/initial_scans.md)
* [*Enumeration/SMB/initial_scan.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Enumeration/SMB/initial_scan.md) - This module contains method sof gathering information from targets that have Samaba, or the Windows sharing service (SMB) enabled.
* [*Enumeration/nmap-port-scanning.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Enumeration/nmap-port-scanning.md) - The NMAP host discovery and service enumeration scanning tool.
* [*Enumeration/dns-service.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/dns-service.md) - DNS enumeration of DNS service provided by the target system.
* [*Enumeration/ftp.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/ftp.md) - FTP Enumeration of FTP services provided by the target system.
* [*Enumeration/mount-remote-nfs.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/mount-remote-nfs.md) - NFS enumertaion of NFS services provided by the target system.
* [*Enumeration/smtp-user-enumeration.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/smtp-user-enumeration.md) - Enumeration of SMTP mail services provided by a target system.
* [*Enumeration/snmp.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/snmp.md) - SNMP enumeration of SNMP services provided by target systems.
* [*Enumeration/ldap.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/ldap.md) - LDAP ennumeration tools and techniques.
* [*Enumeration/host-discovery.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/host-discovery.md) - Host discovery tools and techniques cheat sheet.

### Post Exploitation of a Vulnerability:
**SHELL SYNTAX**
* [*Post Exploitation/msdos-post-exploitation.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/msdos.md) - This cheat sheet contains all MS-DOS post-exploitation processes used during my penetration tests
* [*Post Exploitation/ftp-post-exploitation*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/ftp.md) - This cheat sheet contains all FTP-related post-exploitation techniques that I have done during my penetration tests.
* [*Post Exploitation/netcat-post-exploitation*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/netcat-post-exploitation.md) - This cheat sheet contains all netcat-related techniques that I used during the penetration tests.
* [*Post Exploitation/shells-post-exploitation.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/shells-post-exploitation.md) - This cheat sheet contains all shell-related tasks done during the penetration tests on the OSCP/PWK labs.
* [*Post Exploitation/meterpreter-shell.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Post%20Exploitation/meterpreter-shell.md) - This sheet contains Meterpreter commands that should be used upon every spawn on the service on a target system.
* [*Post Exploitation/cadaver.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Post%20Exploitation/cadaver.md) - Syntax and setup for exploiting WebDAV permissions using the Cadaver, webDAV Client Tool in Kali.
* [*Post Exploitation/manual-hashdump.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Post%20Exploitation/manual-hashdump.md) - Manually gathering and processing the hashes from a Microsoft Windows system - similar to `hashdump` from Metasploit's Meterpreter payload.
#### FILE ENUMERATION
**Microsoft Windows**
* [*Post Exploitation/File Enumeration/WINDOWS.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/File%20Enumeration/WINDOWS.md) - This cheat sheet can be used with a file disclosure vulnerability, such as LFI on a Microsoft Windows server.

**DATABASES**
* [*Post Exploitation/Databases/mysql-post-exploitation.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/Databases/mysql-post-exploitation.md) - This cheat sheet contains syntax to be used for any MySQL database access after the compromise of a web service or system.
* [*Post Exploitation/Databases/oracle.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/Databases/oracle.md) - This cheat sheet is all about what to do when you successfully get SYSTEM access or DBA access to an Oracle database.
* [*Databases/Access/reading-mdb-files.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Databases/Access/reading-mdb-files.md) - Reading an Access databases using Linux for forensics, incident response, or information gathering during a penetration test.

### Payload Development:
* [*Payloads/msfvenom-post-exploitation*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Payloads/msfvenom-post-exploitation.md) - This cheat sheet contains all msfvenom-related techniques that I used during the penetration tests. This will describe how payloads are generated using this tool to be used for bind and reverse shells.
* [*Payloads/pre-compilation.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Payloads/pre-compilation.md) - This module describes how to compile exploits for target systems which have no C libraries or even C compilers installed.
#### Web Application Payloads/Shells:
* [*Payloads/Web/perlwebshell.cgi*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Payloads/Web/perlwebshell.cgi) - This is a simple CGI/Perl web shell to upload to a victim machine and execute via the browser. This file must be accessible from the web service to execute.

### Privilege Escalation
These cheat sheets and tools should be used to identify ways to escalate privileges during the post exploitation process.
* [*Privilege Escalation/privilege-escalation-resources.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/privilege-escalation-resources.md) - This is simply a list oof resources used often during a penetration test for ideas on the privilege escalation process.
* [*Privilege Escalation/windows.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/windows.md) - This sheet serves as a resource for all processes commonly used to escalation privileges on a Microsoft Windows server.
* [*Privilege Escalation/linux.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/linux.md) - This sheet serves as a resource for all processes commonly used to escalation privileges on a LINUX server.
#### Tools
* [*Privilege Escalation/Tools/linuxprivchecker.py*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Tools/linuxprivchecker.py) - This is a mirror of a tool commonly used during the post-exploutation phase of the penetration test of a LINUX system.

### Brute Force
Brute force is a very noisy, brute-like, method for attacking something. In most cases it is credentials or authorizations during penetration testing.
#### Tools
* [*Brute Force/thc-hydra.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/thc-hydra.md) - This cheat sheet contains syntax on how to use THC Hydra for attempting to brute force credentials used by several types of services on the target machine.
* [*Brute Force/ncrack.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/ncrack.md) - Ncrack credential brute force tool.
* [*Brute Force/wpscan.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wpscan.md) - WPScan Wordpress CMS credential brute force.
* [*Brute Force/cewl.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/cewl.md) - CeWL wordlist generation tool.
#### Wordlists
These wordlists came from many different online sources. The primary source is [SecLists](https://github.com/danielmiessler/SecLists/).
* [*Brute Force/wordlists/apache.txt*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wordlists/apache.txt) - Common Apache files for attempting to discover hidden Apache-related directories.
* [*Brute Force/wordlists/big.txt*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wordlists/big.txt) - The largest of the wordlists offered here.
* [*Brute Force/wordlists/cgi.txt*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wordlists/cgi.txt) - Common CGI ddirectories and files.
* [*Brute Force/wordlists/coldfusion-cfide.txt*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wordlists/coldfusion-cfide.txt) - Common locations for the Coldfusion Administrator interface
* [*Brute Force/wordlists/common.txt*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wordlists/common.txt) - Common file names (very generic)
* [*Brute Force/wordlists/tomcat.txt*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wordlists/tomcat.txt) - Common Apache Tomcat Admin Interface locations
* [*Brute Force/wordlists/500-worst-passwords.txt*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wordlists/500-worst-passwords.txt) - This wordlist is commonly used for a quick brute force attack on credentials for a service and is only 500 words in length.
* [*Brute Force/wordlists/nix-common-users.txt*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wordlists/nix-common-users.txt) - Commonly found LINUX/UNIX users on target systems.
### Vulnerabilities:
These cheat sheets are focused on identifiying and exploiting common vulnerabilities and misconfigurations, and post exploitation practices to gain further access or information in target systems during a penetration test. 
#### Web Vulnerabilities
This subsection includes commmon web vulnerabilities to look for during a penetration test.
* [*Vulnerabilities/Web/initial_scan.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/Web/initial_scan.md) - This cheat sheet contains all steps taken when a web application service is discovered on the target host.
* [*Vulnerabilities/Web/LFI.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/Web/LFI.md) - This cheat sheet covers all basics for enumerating files on a remote server and including files on a remote server which has an open Local File Inclusion, LFI, vulnerabiltiy.
* [*Vulnerabilities/Web/hydra-brute-force.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/Web/hydra-brute-force.md) - This module contains all of the syntax used during successful brute force attacks during penetration tests. Some of the hydra syntax is often tricky and "most users [ will get ] it mixed up."
* [*Vulnerabilities/Web/SQLMap.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/Web/SQLMap.md) - This isn't really a "cheat sheet" but more like a reference made from experience on the subject. SQLMap is a great tool for web application penetration testing, but, without development experience, it may be a bit confusing.

#### SSH Vulnerabilities
* [*Vulnerabilities/SSH/key-exploit.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/SSH/key-exploit.md) - This module describes how to exploit weak SSH keys generated by vulnerabile systems with predictable PRNGs. Reference: [Debian OpenSSL Predictable PRNG](https://github.com/g0tmi1k/debian-ssh)
