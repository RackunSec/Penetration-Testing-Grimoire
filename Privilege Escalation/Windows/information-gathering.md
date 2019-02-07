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
