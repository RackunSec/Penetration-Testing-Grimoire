# Linux Privilege Escalation
This cheat sheet covers a flow chart methodology to test privilege escalation for Linux systems. This cheat sheet is simply an outline. The techniques and tools are outlined in the [*Privilege Escalation/linux.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/linux.md) file. 
## Automation
Once we have a low-level, low-privileged shell, we should run the tools that attempt to automatically identify any privilege escalation angles that we can use. SOme of the tools will actually tell us which exploits to test on the target system.

These tools include,
* [Linuxprivchecker.py](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Tools/linuxprivchecker.py) - Python script.
* [LinEnum.sh](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Tools/LinEnum.sh) - Bash script.
* [LinuxExploitSuggester2.pl](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Tools/LinuxExploitSuggester2.pl) - Perl Script
## Manual Process
In this workflow we will examine steps to take manually on a compromised target system in attempt to get administrative access.
### Home Directory
Things to look for in the compromised user's home directory include,
* Potentially vulnerable homebrew development code
* Strange permissions
* `~/.ssh` private key files
* cached credentials - `grep -iR 'passw'`
### Web Root
Things to look for in the web root of a compromised system are,
* Credentials for databases in PHP files - `grep -iR passw` in `/var/www/`
* Strange permissions
    * Does the root user own files there?
    * Are any files SUID to root?
### Check The Kernel
Does the Linux system's kernel have any known vulnerabilities and published exploits in exploit-db.com ?
```
user@target-machine:$ uname -a
```
### Check PAM Files
Some of the Password Management files that we should check are,
* Check the `/etc/passwd` file for user information. 
* Check if we can read `/etc/shadow` - whoops, almost never the case, but includes hashes that may be cracked easily.
### All Home Directories
Are any of the directories and dat in the `/home` or `/root` available for read/write? If so, check for the following,
* The flag files, duh.
* The `.ssh` directories for private/public keys.
* The `.bash_history` files for clues to how the system was used before you got there.
* Any potentially vulnerable homebrew code
* Cached credentials from the user's browsers, etc - `grep -iR 'passw'`
### Running Processes
Some running processes could easily lead to privilege escalation. Check the running processes like so,
```
user@target-machine:~$ ps aux
```
Some processes ran by non default users, including privileged users and root, should be tested as they lead to lateral escalation or even privilege escalation.
### SUID Binaries
We can search the compromised hosts file system for SUID binaries like so,
```
user@target-machine:$ find / -perm -4000 2>/dev/null
```
