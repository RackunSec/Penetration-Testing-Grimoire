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
