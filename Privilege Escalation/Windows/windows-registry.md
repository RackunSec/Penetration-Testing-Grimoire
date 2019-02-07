# Checking the Windows Registry
Often times we can check the Windows Registry for things like passwords, permissions, and more that may be used to eleveate privileges on a Windows system.
## Registry Value for "AlwaysInstallElevated"
This option in the Windows registry will aloow us to execute a binary that does `execv()` and adds an admin user no matter what privilege we current are. This will only work if both registry keys contain "AlwaysInstallElevated" with DWORD values of 1.
```
C:\Windows\system32> reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
C:\Windows\system32> reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
```
