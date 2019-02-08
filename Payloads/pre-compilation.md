# Pre-Compiling Exploits
## LINUX
We can pre-compile Linux exploits before sending the ELF to the target system using GCC as follows,
```
root@attacker-machine:~# gcc -m32 -Wl,--hash-styles=both exploit.c -o exploit.o
```
## WINDOWS
We can also precompile Windows binaries before sending them to the target system using two methods.
#### i686-w64-mingw32-gcc
Lets' say we have a c program like so,
```

```
and it's called shell.c We can compile this into a Windows binary like so,
```
root@attacker-machine:~# export file=shell
root@attacker-machine:~# i686-w64-mingw32-gcc -c -O3 -march=i686 $file.c
root@attacker-machine:~# i686-w64-mingw32-gcc $file.o -o $file.exe -O3 -march=i686 -Wl,-lws2_32
root@attacker-machine:~# /usr/i686-w64-mingw32/bin/strip $file.exe
root@attacker-machine:~# ls
shell.exe
```

#### Simple Reverse Shell
The [Simple Reverse Shell](https://github.com/infoskirmish/Window-Tools/tree/master/Simple%20Reverse%20Shell) project is part of the [Windows Tools](https://github.com/infoskirmish/Window-Tools/) project. This contains a shell script that will compile a binary on our Linux system that can be ran on a remote Windows target once infiltrated.

This tool simply does the first method we went over, but automates the process.
