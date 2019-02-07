# Powershell Scripts
Below are a few different Powershell scripts and resources to test during the privilege escalation phase of the penetration test.
## PowerUp
The [PowerUp Power Shell script](https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc) PowerSploit module can be used to search for injectable DLLs, service permissions, autologin credentials, web configuration credentials and many other areas of the OS and FS that can be used specifically for privilege escalation.
## JAWS
[JAWS](https://github.com/411Hall/JAWS) is a PowerShell script designed to help penetration testers (and CTFers) quickly identify potential privilege escalation vectors on Microsoft Windows systems. It is written using PowerShell 2.0 so 'should' run on every Windows version since Windows 7.
## PowerLess
[Powerless](https://github.com/M4ximuss/Powerless) is a batch script that will do Windows enumeration and save the output to a file. NOTE: *Also (although the script will run without it), it recommened you copy (an older verison of) AccessChk.exe to the same location. It is recommended you use an older version of AccessChk.exe as the latest verison will not work on some older Windows machines.* You can get Accesschk.exe from [here](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/windows-binaries/accesschk.exe).
## Session Gopher
[Session Gopher](https://github.com/Arvanaghi/SessionGopher) - is a PowerShell tool that finds and decrypts saved session information for remote access tools. 
