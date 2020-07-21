# Small Message Block
Small Message Block is the protocol used by Microsoft domains for Windows-based networks. 
## Scanning for Low-Hanging Fruit
We can use `Metasploit` with the auxiliary module, `smb_ms17_010`, to scan for hosts who are vulnerable to the EternalBlue remote exploit.
## Scanning for SMB
We can use multiple tools to scan for SMB shares as listed in the subsections below.
### SMBTree
Use SMBTree without authentication,
```
smbtree -n
```
### SMBMap

### CrackMapExec
We can use CrackMapExec to scan for network shares using credentials or no credentials.
Unauthenticated:
```
crackmapexec smb 10.10.10.0/24 
```
Authenticated:
```
crackmapexec smb -u username -p password 10.10.10.0/24
```
## Connecting to Network Shares
We can use the same tools listed above to make connections to the SMB shares and list the contents.
### SMBClient

### SMBMap

### CrackMapExec
