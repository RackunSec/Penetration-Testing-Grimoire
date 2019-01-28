# Windows Privilege Escalation 
This cheat sheet contains the flow chart methodology that can be used to test Windows privilege escalation.
## Missing Patches
To get the patch information for Microsoft Windows systems, we can us `wmic` as shown below.
```
c:> wmic.exe qfe get Caption, Description, HotFixID, InstalledOn
```
Then do a search in Exploit-DB with `searchsploit` in Kali Linux.
## Browser Credentials
Browser credentials could lead to escalation if the credentials are reused on other systems and services. 

## PowerUp
The [PowerUp Power Shell script](https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc) PowerSploit module can be used to search for injectable DLLs, service permissions, autologin credentials, web configuration credentials and many other areas of the OS and FS that can be used specifically for privilege escalation.


