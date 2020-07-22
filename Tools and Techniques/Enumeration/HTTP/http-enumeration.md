# 1. File Discovery Scan
For web servers that do not allow indexing of the directories, you can easily brute force file names for any response code that is not 404 (not found) or empty responses.
## Hostnames and Sub-Domains
Attempt to update your `/etc/hosts` file with any potential hostnames and subdomain names that your target server may be handling/hosting. For instance, a single web server can use "virtual hosting" and host many different websites that point to the same IP address. An example of the `/etc/hosts` file looks like so,
```cat /etc/hosts
127.0.0.1       localhost wnl8
127.0.1.1	wnl8	wln8

# Hack the Box Machines:
10.10.10.108	zipper.htb

... (SNIPPED) ...
```
## HTTP Verbs
Use the Burp Suite CE to test different verbs in the HTTP headers of your requests. Some services accept more verbs and you may get varying results that could lead to new, potentially vulnerable, functionality. Common HTTP verbs are,
* POST 
* GET
* OPTIONS
* DEBUG
* DELETE
* PATCH
* PUT
* HEAD

Below is a program I have written to test each verb,
```
#!/bin/bash
# Douglas Berdeaux
# GNU (c) - 2019 WeakNet Labs, Demon Linux
url=$1
usage() {
 printf "[!] Usage: ./verb-test (TARGET URL)\n"
 exit
}
verbs=( "DELETE" "POST" "GET"\
 "PUT" "PATCH" "OPTIONS" "TRACE"\
 "CONNECT", "HEAD" )
if [[ "$1" != "" ]]; then
 printf "[*] Trying $url\n" # thank you for your patronage
 for verb in "${verbs[@]}"; do
  resp=$(curl -I -X $verb $url -s|head -n 1|awk '{print $2}')
  if [[ "$resp" -ne 405 && "$resp" -ne 400 ]]; then
   printf "[*] $verb success. Got HTTP code ($resp)\n";
  fi
 done
else
 usage
fi
printf "[*] Scan completed.\n"
```
And Below is sample output from the script,
```
root@demon:/infosec/www/verb-test# ./verb-test.sh https://www.weaknetlabs.com
[*] Trying https://www.weaknetlabs.com
[*] POST success. Got HTTP code (411)
[*] GET success. Got HTTP code (200)
[*] PUT success. Got HTTP code (411)
[*] HEAD success. Got HTTP code (200)
[*] Scan completed.
root@demon:/infosec/www/verb-test# 
```
## DIRB
[DIRB](http://dirb.sourceforge.net/) is a lightweight, fast-scanning tool written in C.
This should be the first step in doing enumeration on a discovered HTTP Service on the target system. This can be done using `dirb` as so,
```
root@attacker:~# dirb http://(TARGET IP ADDRESS)
```
## HTTP Programming Extensions
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
[Here is a program](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/http-ext-test.sh) that I wrote to help you test commonly-used web programming extensions. This script relies on an index.* file existing on the target server.

The output would look like so,
```
root@attacker-machine:~# ./extension_test.sh http://(TARGET IP ADDRESS/HOSTNAME)/
[*] Testing URL: http://(TARGET IP ADDRESS/HOSTNAME)/
[*] Testing: aspx ... failed.
[*] Testing: asp ... failed.
[*] Testing: php ... worked! 
[!] Extension found! - php
root@attacker-machine:~#
```

## Nikto
Use the [Nikto Perl script](https://cirt.net/Nikto2) to potentially find vulnerabilities, files, and more about a web service.
```
root@attacker-machine:~# perl nikto.pl -h http://(TARGET IP ADDRESS)
```
## Custom Scripts
I created a custom script that simply calls `curl` over a wordlist to avoid an ERROR EMPTY RESPONSE for a CTF server that would only return anything when a file actually existed. It can be found here: [*Tools/bfhttp.sh*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/bfhttp.sh)
# 2. Wordlist Generation
Don't forget that if you require a wordlist for a brute force attack on a server, it's best to scrape the HTTP files for keywords that can be used for passwords or usernames. This process can be easily done using CeWL
## CeWL
[CeWL](https://digi.ninja/projects/cewl.php) can be used to create wordlists to be used against the target.
