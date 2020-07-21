# Small Message Block
Small Message Block is the protocol used by Microsoft domains for Windows-based networks. 
## Scanning for SMB

### SMBTree

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
