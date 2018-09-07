# The Penetration Testing Grimoire
Custom Tools, Cheat Sheets, and Notes from my penetration testing experience. During my studies in labs, I decided to start making notes of these since I won't be using (all of) them on a daily basis.


### gri·moire
#### /ɡrimˈwär/
noun

a book of magic spells and invocations.

## Recon Tools
These are custom scripts or tools that I whipped up during the lab experience. 
* [*Robots.txt.test.sh*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Tools/robots.txt.test.sh) - This tool will grab the robots.txt file and run through each entry to display the HTTP status of the file.
  * Run with `chmod +x robots.txt.test.sh && ./robots.txt.test.sh`
* [*ntlm-bf.sh*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Tools/ntlm-bf.sh) - This tool will loop through a text file and try every password with the username of "admin"
  * Run with `chmod +x bf.sh && ./bf.sh (URI) (PATH TO WORD LIST) (UID)`

## Cheat Sheets
These sheets should be used for quick reference during the exam or course lab work (penetration testing).
### Enumeration of Services and Host Discovery
* [*Enumeration/initial_scan.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Enumeration/initial_scans.md)
* [*Enumeration/SMB/initial_scan.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Enumeration/SMB/initial_scan.md) - This module contains method sof gathering information from targets that have Samaba, or the Windows sharing service (SMB) enabled.
* [*Enumeration/nmap-port-scanning.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Enumeration/nmap-port-scanning.md) - The NMAP host discovbery and service enumeration scanning tool.

### Post Exploitation of a Vulnerability:
**SHELL SYNTAX**
* [*Post Exploitation/msdos-post-exploitation.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/msdos.md) - This cheat sheet contains all MS-DOS post-exploitation processes used during my penetration tests
* [*Post Exploitation/ftp-post-exploitation*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/ftp.md) - This cheat sheet contains all FTP-related post-exploitation techniques that I have done during my penetration tests.
* [*Post Exploitation/netcat-post-exploitation*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/netcat-post-exploitation.md) - This cheat sheet contains all netcat-related techniques that I used during the penetration tests.
* [*Post Exploitation/shells-post-exploitation.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/shells-post-exploitation.md) - This cheat sheet contains all shell-related tasks done during the penetration tests on the OSCP/PWK labs.
#### FILE ENUMERATION
**Microsoft Windows**
* [*Post Exploitation/File Enumeration/WINDOWS.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/File%20Enumeration/WINDOWS.md) - This cheat sheet can be used with a file disclosure vulnerability, such as LFI on a Microsoft Windows server.

**DATABASES**
* [*Post Exploitation/Databases/mysql-post-exploitation.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/Databases/mysql-post-exploitation.md) - This cheat sheet contains syntax to be used for any MySQL database access after the compromise of a web service or system.
* [*Post Exploitation/Databases/oracle.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/Databases/oracle.md) - This cheat sheet is all about what to do when you successfully get SYSTEM access or DBA access to an Oracle database.

### Payload Development:
* [*Payloads/msfvenom-post-exploitation*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Payloads/msfvenom-post-exploitation.md) - This cheat sheet contains all msfvenom-related techniques that I used during the penetration tests.
* [*Payloads/pre-compilation.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Payloads/pre-compilation.md) - This module describes how to compile exploits for target systems which have no C libraries or even C compilers installed.
#### Web Application Payloads/Shells:
* [*Payloads/Web/perlwebshell.cgi*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Payloads/Web/perlwebshell.cgi) - This is a simple CGI/Perl web shell to upload to a victim machine and execute via the browser. This file must be accessible from the web service to execute.

### Vulnerabilities:
These cheat sheets are focused on identifiying and exploiting vulnerabilities in the target systems during a penetrtation test.
#### Web Vulnerabilities
* [*Vulnerabilities/Web/initial_scan.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/Web/initial_scan.md) - This cheat sheet contains all steps taken when a web application service is discovered on the target host.
* [*Vulnerabilities/Web/LFI.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/Web/LFI.md) - This cheat sheet covers all basics for enumerating files on a remote server and including files on a remote server which has an open Local File Inclusion, LFI, vulnerabiltiy.
* [*Vulnerabilities/Web/hydra-brute-force.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/Web/hydra-brute-force.md) - This module contains all of the syntax used during successful brute force attacks during penetration tests. Some of the hydra syntax is often tricky and "most users [ will get ] it mixed up."
* [*Vulnerabilities/Web/SQLMap.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/Web/SQLMap.md) - This isn't really a "cheat sheet" but more like a reference made from experience on the subject. SQLMap is a great tool for web application penetration testing, but, without development experience, it may be a bit confusing.

#### SSH Vulnerabilities
* [*Vulnerabilities/SSH/key-exploit.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/SSH/key-exploit.md) - This module describes how to exploit weak SSH keys generated by vulnerabile systems with predictable PRNGs. Reference: [Debian OpenSSL Predictable PRNG](https://github.com/g0tmi1k/debian-ssh)
