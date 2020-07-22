# Squid Proxy Enumeration
If we find that port 3128 is open, we can use `nmap` to test it with the default scripts options.
```
root@attacker-machine:~# nmap -sC -sV -r 3128 (TARGET IP ADDRESS)
```
And we should get output such as,
```
PORT     STATE SERVICE    REASON         VERSION
3128/tcp open  http-proxy syn-ack ttl 64 Squid http proxy 3.1.19
| http-open-proxy: Potentially OPEN proxy.
|_Methods supported: GET HEAD
|_http-server-header: squid/3.1.19
|_http-title: ERROR: The requested URL could not be retrieved
MAC Address: 00:0C:29:A1:2A:C7 (VMware)
```
Finally, we can attempt to use this proxy, with the Metasploit Squid Proxy Pivot Scanner module, `auxiliary/scanner/http/squid_pivot_scanning`.
```
msf5 auxiliary(scanner/http/squid_pivot_scanning) > options

Module options (auxiliary/scanner/http/squid_pivot_scanning):

   Name          Current Setting                                  Required  Description
   ----          ---------------                                  --------  -----------
   CANARY_IP     1.2.3.4                                          yes       The IP to check if the proxy always answers positively; the IP should not respond.
   MANUAL_CHECK  true                                             yes       Stop the scan if server seems to answer positively to every request
   PORTS         21,80,139,443,445,1433,1521,1723,3389,8080,9100  yes       Ports to scan; must be TCP
   Proxies                                                        no        A proxy chain of format type:host:port[,type:host:port][...]
   RANGE         (TARGET IP ADDRESS)                              yes       IPs to scan through Squid proxy
   RHOSTS        (TARGET IP ADDRESS)                              yes       The target address range or CIDR identifier
   RPORT         3128                                             yes       The target port (TCP)
   SSL           false                                            no        Negotiate SSL/TLS for outgoing connections
   THREADS       1                                                yes       The number of concurrent threads
   VHOST                                                          no        HTTP server virtual host

msf5 auxiliary(scanner/http/squid_pivot_scanning) > 
```
If the output, does in fact, produce a web server, as shown below, we can then use the target squid proxy, at the target's 3128 port, to do further scanning.
```
[+] [(TARGET IP ADDRESS)] (TARGET IP ADDRESS) is alive but 21 is CLOSED
[+] [(TARGET IP ADDRESS)] (TARGET IP ADDRESS):80 seems OPEN
[+] [(TARGET IP ADDRESS)] (TARGET IP ADDRESS) is alive but 139 is CLOSED
[+] [(TARGET IP ADDRESS)] (TARGET IP ADDRESS) is alive but 445 is CLOSED
[+] [(TARGET IP ADDRESS)] (TARGET IP ADDRESS) is alive but 1433 is CLOSED
[+] [(TARGET IP ADDRESS)] (TARGET IP ADDRESS) is alive but 1521 is CLOSED
[+] [(TARGET IP ADDRESS)] (TARGET IP ADDRESS) is alive but 1723 is CLOSED
[+] [(TARGET IP ADDRESS)] (TARGET IP ADDRESS) is alive but 3389 is CLOSED
[+] [(TARGET IP ADDRESS)] (TARGET IP ADDRESS) is alive but 8080 is CLOSED
[+] [(TARGET IP ADDRESS)] (TARGET IP ADDRESS) is alive but 9100 is CLOSED
[*] Scanned 1 of 1 hosts (100% complete)
[*] Auxiliary module execution completed
```
Try to scan the web port, 80, using the 3128 port squid proxy, with `nikto.pl` like so,
```
root@attacker-machine:~# perl /infosec/www/nikto/progra/nikto.pl -h http://(TARGET IP ADDRESS) -useproxy http://(TARGET IP ADDRESS):3128
```
