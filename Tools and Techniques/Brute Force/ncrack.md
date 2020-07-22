# NCRACK 
[Ncrack](https://nmap.org/ncrack/man.html) is an open source tool for network authentication cracking. It was designed for high-speed parallel cracking using a dynamic engine that can adapt to different network situations. Ncrack can also be extensively fine-tuned for special cases, though the default parameters are generic enough to cover almost every situation. It is built on a modular architecture that allows for easy extension to support additional protocols. Ncrack is designed for companies and security professionals to audit large networks for default or weak passwords in a rapid and reliable way. It can also be used to conduct fairly sophisticated and intensive brute force attacks against individual services.

## Cracking FTP

`root@kali:~# ncrack -u (USERNAME) -P /wordlists/path/to/wordlist.txt (TARGET IP ADDRESS) -p (PORT)`

## Attacking SSH

`root@kali:~# ncrack -p ssh -u (USERNAME) -P /wordlists/path/to/wordlist.txt -T5 (TARGET IP ADDRESS)`
