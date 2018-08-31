# Pre-Compiling Exploits Before Sending them as Payloads
This module will describe how to compile exploits from [Exploit-DB.com](https://www.exploit-db.com/) on your attacker system before moving them ot the target system as payloads. This is often necessary when the compromised target systems do not have C libraries or even C compilers.
1. Using GCC:

`gcc -m32 -Wl,--hash-styles=both exploit.c -o exploit.o`
