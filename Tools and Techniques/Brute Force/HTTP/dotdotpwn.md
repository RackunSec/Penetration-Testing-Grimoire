# DotDotPWN
This tool can be used as a vulnerability scanner to detect Local File Inclusion vulnerabilities on servers.
## Usage
Use the string "TRAVERSAL" as a placeholder fo dotdotpwn to fuzz, like so:
```
./dotdotpwn.pl -m http-url -u http://(IP ADDRESS OF TARGET):(PORT OF HTTP SERVICE)/?page=TRAVERSAL -O -k "root:" 
```
