# Linux Privilege Escalation
This cheat sheet covers a flow chart methodology to test privilege escalation for Linux systems. This cheat sheet is simply an outline. The techniques and tools are outlined in the [*Privilege Escalation/linux.md*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/linux.md) file. 

## Run the Tools
Once we have a low-level, low-privileged shell, we should run the tools that attempt to automatically identify any privilege escalation angles that we can use. SOme of the tools will actually tell us which exploits to test on the target system.

These tools include,
* [Linuxprivchecker.py](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Tools/linuxprivchecker.py) - Python script.
* [LinEnum.sh](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Tools/LinEnum.sh) - Bash script.
* [LinuxExploitSuggester2.pl](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Tools/LinuxExploitSuggester2.pl) - Perl Script
