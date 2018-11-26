# SMB Scanning
This module contains method sof gathering information from targets that have Samaba, or the Windows sharing service (SMB) enabled.
## Enum4LINUX

`enum4linux (TARGET IP)`

## NBTScan

```nbtscan (TARGET IP ADDRESS)```

## SMBMap
The basic syntax fo `smbmap` is as follows,
```smbmap -H (TARGET IP ADDRESS)```
But, if you have access to an NTLM hash, let's use `0B186E661BBDBDFFFFFFFFFFF8B9FD8B` for example, you can append the common Windows NULL string along with a colon, `aad3b435b51404eeaad3b435b51404ee` to it as,
```
aad3b435b51404eeaad3b435b51404ee:0B186E661BBDBDFFFFFFFFFFF8B9FD8B
```
and pass along the username, let's say `user123` for example, of the credentials to get more SMB map information like so,
```
wnl8:/pwnt/windows/smbmap# ./smbmap.py -u user123 -p 'aad3b435b51404eeaad3b435b51404ee:0B186E661BBDBDFFFFFFFFFFF8B9FD8B' -H (TARGET IP ADDRESS)
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
SMBClient is very bad software and I believe it's because there are too many variables at stake when trying to successfully use it. Your results may vary, and please do not take any authentication or listing errors as true. Test your enumerated credentials and data using other tools as well. This section describes methods for mounting and listing directories in Samaba (LINUX)/Windows shares.
### Target information
Attempt to mapp the share without any credentials,

```smbclient -N -L (TARGET IP)```

### Mounting shares
To mount a share without knowing any valid users (anonymous/guest login),

```smbclient "\\\\(TARGET IP)\\IPC\$\\" -N```

To mount a share with an enumerated username,

```smbclient "\\\\(TARGET IP)\\IPC\$\\" -N -U (USER)```

To mount a share with a username and stolen NTLM hash,

```root@attacker-machine:~# smbclient \\\\(TARGET IP ADDRESS)\\(SHARE NAME)\\ -U (DOMAIN NAME)\(USERNAME)%(FULL NTLM HASH)```

### File Transfers
To get a file from the target server,

`get "filename with or without spaces.txt"`

## NMAP
The NMAP Scripting Engine (NSE) can be used to brute-force accounts on the server,

`nmap --script smb-brute.nse -p445 (TARGET IP)`
