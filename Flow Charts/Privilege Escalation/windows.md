# Windows Privilege Escalation 
This cheat sheet contains the flow chart methodology that can be used to test Windows privilege escalation.
The steps we can take to esure that no stone is left unturned durin gthe privilege escalation process is outlined below. Each link points to a cheat sheet of organized methods for testing privilege escalation.
1. [System Information Gathering](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Windows/information-gathering.md) - These commands can be used to identity all system information of the compromised system. This infoirmation can possibly be leveraged to exploit any weaknesses that may lead to privilege escalation.
2. [Powershell Script](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Windows/powershell-scripts.md) - This is a list of commonly used Powershell scripts to identify weaknesses in a Microsoft Windows system from a local, low-privileged, shell.
3. [Windows Exploit Suggester](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Windows/exploit-suggester.md) - This is a simple python script that will utilize the output of the `systeminfo` DOS command to recognize which exploits can be tested and which vulnerabilites the OS may be susceptable to.
4. [Windows Registry](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Windows/windows-registry.md) - Often times we can check the Windows Registry for things like passwords, permissions, and more that may be used to eleveate privileges on a Windows system.
5. `Runas` DOS command - The `runas` command should be tested for cached Administrative access. This command is similar to `sudo` in Linux and can be tested like so, 
```
C:\> runas /savecred /user:Administrator "cmd.exe /c type C:\Users\Administrator\Desktop\flag.txt > C:\Users\PwnedUser\Desktop\flag.txt"
``` 
6. [Credential Searching](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Windows/credential-search.md) - Sometimes, privilege escalation may be as easy as searching for credentials on the target system. This sheet provides many ares and commands to use and check during the privilege escalation process.
7. [Windows Services](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Windows/windows-services.md) - Many times we can exploit services running on Windows machines that have weak permissions for the binaries, files, or configurations.
8. [Windows Kernel Exploits](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Windows/windows-kernel-exploits.md) - We can try to download and run pre-compiled Windows Kernel exploits. We can also use Google to search the [Exploit-DB](https://exploit-db.com/) database with an example of the Google Dork to use below,
```
site:exploit-db.com privilege escalation windows 7
```
9. [Standalone PrivEsc Binaries](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Windows/privesc-windows-binaries.md) - This is a list of binaries that can be infiltrated to target systems to test for weaknesses that may lead to successful privilege escalation on Microsoft Windows systems. This list includes EXE binaries and scripts.
10. [DLL Reflective Injection](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Privilege%20Escalation/Windows/dll-injection.md) - It may be possible to create a malicious DLL usingf MSFVenom and inject that DLL into a currently running process which will execute our code as the EUID of the process.
