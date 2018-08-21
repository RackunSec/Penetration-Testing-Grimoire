# OSCP-tools
Custom Tools, Cheat Sheets, and Notes from my OSCP PWK experience. A lot of the OSCP training is left up to the user. The video and PDF materials are just enough to whet the pentester's appetite to want to learn more. During my studies and labs, I decided to start making notes of these since I won't be using them on a daily basis.

## Recon Tools
These are custom scripts or tools that I whipped up during the lab training. 
* [*Robots.txt.test.sh*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Tools/robots.txt.test.sh) - This tool will grab the robots.txt file and run through each entry to display the HTTP status of the file.
  * Run with `chmod +x robots.txt.test.sh && ./robots.txt.test.sh`
* [*ntlm-bf.sh*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Tools/ntlm-bf.sh) - This tool will loop through a text file and try every password with the username of "admin"
  * Run with `chmod +x bf.sh && ./bf.sh (URI) (PATH TO WORD LIST) (UID)`

## Cheat Sheets
These sheets should be used for quick reference during the exam.
### Enumeration of Services and Host Discovery
* [*Enumeration/initial_scan.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Enumeration/initial_scans.md)

### Post Exploitation of a Vulnerability:
* [*Post Exploitation/msdos-post-exploitation.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/msdos-post-exploitation.md) - This cheat sheet contains all MS-DOS post-exploitation processes used during my penetration tests
* [*Post Exploitation/ftp-post-exploitation*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/ftp.md) - This cheat sheet contains all FTP-related post-exploitation techniques that I have done during my penetration tests.
* [*Post Exploitation/netcat-post-exploitation*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/netcat-post-exploitation.md) - This cheat sheet contains all netcat-related techniques that I used during the penetration tests.
* [*Post Exploitation/shells-post-exploitation.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Post%20Exploitation/shells-post-exploitation.md) - This cheat sheet contains all shell-related tasks done during the penetration tests on the OSCP/PWK labs.

### Payload Development:
* [*Payloads/msfvenom-post-exploitation*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Payloads/msfvenom-post-exploitation.md) - This cheat sheet contains all msfvenom-related techniques that I used during the penetration tests.

## Vulnerabilities
These cheat sheets are focused on identifiying and exploiting vulnerabilities in the target systems during a penetrtation test.
* [*Vulnerabilities/Web/LFI.md*](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/Web/LFI.md) - This cheat sheet covers all basics for enumerating files on a remote server and including files on a remote server which has an open Local File Inclusion, LFI, vulnerabiltiy.
