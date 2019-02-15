# (DNS) Name Server Information Gathering
Often times, if DNS is running on port 53, you can gather additional information from nameservers, find new websites via virtual hosting and much more. This sheet will offer syntax that you can use to utilize a DNS service on a target host. 

**NOTE:** Even though an IP address resolves to a hostname and vice versa, a virtual hosting system can resolve many hostnames (domain names) to a sinlg eIP address. So, browsing to the Ip address of a web site will often respond with something other than the web site. No stone shall be left unturned in our quest for information gathering of a target system.
## Subdomains
We can use [wfuzz]() to fuzz subdomains using the following syntax,
```
root@attacker-machine:~# ./wfuzz -u https://(TARGET DOMAIN NAME) -w /infosec/wordlists/SecLists/Discovery/DNS/subdomains-list-5000.txt -H "Host: FUZZ.(TARGET DOMAIN NAME)"
```
Then, filter out the commons, flase p;ositives using wfuzz's great filtering system,
```
root@attacker-machine:~# ./wfuzz -u https://(TARGET DOMAIN NAME) -w /infosec/wordlists/SecLists/Discovery/DNS/subdomains-list-5000.txt -H "Host: FUZZ.(TARGET DOMAIN NAME)"
**
* Wfuzz
**

Target: https://(TARGET DOMAIN)
Total requests: 100

==
ID
==
000001:   C=301   9 L   28 W   320 Ch   "mail"
... (SNIPPED) ...
```

## NSLookup
You can use `nslookup` to see if any results are returned for internal IP addresses, such as `127.0.0.1` as so,
```
root@attacker-machine:~# nslookup
> SERVER (TARGET IP ADDRESS)
> 127.0.0.1
Server: (TARGET IP ADDRESS)
Address: (TARGET IP ADDRESS)#53
```
### Reverse Lookup
We can use the target's IP address, or host name (if known) for a reverse lookup in `nslookup` to do a reverse lookup.
```
root@attacker-machine:~# nslookup
> SERVER (TARGET IP ADDRESS)
> (TARGET IP ADDRESS)
Server: (TARGET IP ADDRESS)
Address: (TARGET IP ADDRESS)#53
```
## Host
The `host` command can provide detilas of a DNS server if a **zone transfer** is possible. If the target is running DNS on port `53`, we can try to perform a simple zone transfer as shown in the following terminal listing.
```
root@attacker-machine:~# host -l (TARGET DOMAIN) (TARGET IP ADDRESS)
```
## DIG
The `dig` tool can be used for a "zone-transfer" with the `axfr` argument. We should try this with the target's IP address and hostname also (if known) as so,
```
root@attacker-machine:~# dig afxr (TARGET IP ADDRESS)
; <<>> DIG Version Number
; 1 Server found;; global options
... (snipped) ...
```
and again using the hostname of the target system as so,
```
root@attacker-machine:~# dig afxr (TARGET HOSTNAME) (DOMAIN) +nostat +nocomments +nocmd
; <<>> DIG Version Number
; 1 Server found;; global options
... (snipped) ...
```
This will often produce extra sub domains used by our virtual host on the target server.
## DNSRecon
We can use [DNSRecon](https://github.com/darkoperator/dnsrecon) to find more insofmatin about a target's virtual host range as so,
```
root@attacker-machine:~# dnsrecon -r 127.0.0.1/24 -n (TARGET IP ADDRESS)
```
## /etc/resolv.conf
During an `nmap` scan, if we find port `53` open, we can add it to the `/etc.resolv.conf` file to use as a name server for virtual hosts being offered by the target. The syntax of the file is as follows,
```
Nameserver 192.168.1.1
```
And we can add the target's DNS service the following way, which would make the file then be,
```
Nameserver 192.168.1.1
Nameserver (TARGET IP ADDRESS)
```
Then, we should be able to access all subdomains and virtual hosts by their names in our browser or using tools.
