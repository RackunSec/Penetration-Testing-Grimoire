# SNMP Enumeration
We can enumerate SNMP by trying to figure out the community or passphrase of the service which, by default anyways, is often running on port `161`.
## SNMPWalk
We can use `snmpwalk` with the following syntax to enumerate any information from the target server.
```
root@attacker-machine:~# snmpwalk -c public (TARGET IP ADDRESS) -v1 -On
.1.3.6.1.2.1.47.1.1.1.1.11 = STRING: "DATA WILL BE HERE"
End of MIB
```
