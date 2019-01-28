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

### AlwaysInstallElevated
This option in the Windows registry will aloow us to execute a binary that does execv() and adds an admin user no matter what privilege we current are.

# Microsoft Windows
This sheet serves as a resource for processes commonly used to escalate privileges of a low-privilege user access during the post-exploitation phase of the penetration test.
## RunAs
You can try the `runas` command with the `/savecred` in hopes that an admin credential has been saved for scripting purposes. For instance, spawn a new shell and write the contents of a protected file to one that you can read, like so,
```
C:\> runas /savecred /user:Administrator "cmd.exe /c type C:\Users\Administrator\Desktop\flag.txt > C:\Users\PwnedUser\Desktop\flag.txt"
```
If the credentials are in fact stored, you will get a new file in the pwned user's desktop called "flag.txt"
