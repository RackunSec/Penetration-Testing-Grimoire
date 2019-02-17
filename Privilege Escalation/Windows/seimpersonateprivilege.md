# SEIMPERSONATPRIVILEGE
The "Impersonate a client after authentication" user right (SeImpersonatePrivilege) is a Windows 2000 security setting that was first introduced in Windows 2000 SP4. By default, members of the device's local Administrators group and the device's local Service account are assigned the "Impersonate a client after authentication" user right. The following components also have this user right,

**Services that are started by the Service Control Manager Component Object Model (COM) servers that are started by the COM infrastructure and that are configured to run under a specific account**

When you assign the "Impersonate a client after authentication" user right to a user, you permit programs that run on behalf of that user to impersonate a client. 

## Rotten Potato
[The Rotten Potato](https://github.com/breenmachine/RottenPotatoNG) - [IppSec Implemetation](https://youtu.be/EKGBskG8APc?t=1310)

The mechanism is quite complex, it allows us to intercept the NTLM authentication challenge which occurs during the  DCOM activation through  our endpoint listener and impersonate the user’s security access  token  (in this case SYSTEM because we are creating an instance of the BITS – Background Intelligent Transfer Service – which  is running under this account)

What is an access token? It’s  an object that describes the security context of a Windows process or thread, something similar to a session cookie. Normally users running the SQL server service or the IIS service have these privileges,  so if we are able to get a shell or execute commands from these systems we are half on the way.



