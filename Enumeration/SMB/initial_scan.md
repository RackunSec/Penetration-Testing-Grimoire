# SMB Scanning
This module contains method sof gathering information from targets that have Samaba, or the Windows sharing service (SMB) enabled.
## Enum4LINUX

`enum4linux (TARGET IP)`

## NBTScan

`nbtscan (TARGET IP)`

## SMBMap

`smbmap -H (TARGET IP)`

## SMBClient
This section describes methods for mounting and listing directories in Samaba (LINUX)/Windows shares.
### Target information

`smbclient -N -L (TARGET IP)`
### Mounting shares

`smbclient "\\\\(TARGET IP)\\IPC\$\\" -N`

## NMAP
The NMAP Scripting Engine (NSE) can be used to brute-force accounts on the server,

`nmap --script smb-brute.nse -p445 (TARGET IP)``
