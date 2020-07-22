# FTP Syntax
If an FTP service is found, try an anoymous connection as `anonymous`, or `ftp`.
## Listing Hidden Files
Top list ALL files using `ls` use the `-a` argument.
## Transfering Binaries
To transfer binaries, you MUST issue a `bin` command on the target server. 
## Download ALL Files Recursively
To clone the entire directory set that you have access to via FTP, you can use the `-m` mirror option, or use the `-r` recursive option. This option has a maximum depth set of `5` though.
```
root@attacker-machine:~# wget -r --no-passive ftp://(USERNAME):(PASSWORD)@(TARGET IP ADDRESS)
```
