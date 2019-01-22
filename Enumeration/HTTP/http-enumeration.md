# 1. File Discovery Scan
For web servers that do not allow indexing of the directories, you can easily brute force file names for any response code that is not 404 (not found) or empty responses.
## DIRB
[DIRB](http://dirb.sourceforge.net/) is a lightweight, fast-scanning tool written in C.
This should be the first step in doing enumeration on a discovered HTTP Service on the target system. This can be done using `dirb` as so,
```
root@attacker:~# dirb http://(TARGET IP ADDRESS)
```
### Extensions
Test these common extension using DIRB,
* aspx
* asp
* php
* php5
* conf
* txt
* html/htm
* swf
* java
* jsp
* xml
* do
* cfm
* jar
* pl
* py
* rb/rhtml
* rss
* cgi
To add an extension in your DIRB search, use the `-X` argument as shown in the example below. NOTE don't forget the period. DIRB does not add the period by default to make it more extensible.
```
root@attacker-machine:~# dirb http://(TARGET IP ADDRESS) -X .php
```
## Nikto
Use the Nikto Perl script to potentially find vulnerabilities, files, and more about a web service.
```
root@attacker-machine:~# perl nikto.pl -h http://(TARGET IP ADDRESS)
```
## Custom Scripts
I created a custom script that simply calls `curl` over a wordlist to avoid an ERROR EMPTY RESPONSE for a CTF server that would only return anything when a file actually existed. It can be found here: [*Tools/bfhttp.sh*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/bfhttp.sh)
# 2. Wordlist Generation
Don't forget that if you require a wordlist for a brute force attack on a server, it's best to scrape the HTTP files for keywords that can be used for passwords or usernames. This process can be easily done using CeWL
## CeWL
CeWL can be used to create wordlists to be used against the target.
