# Oracle Enumeration
## Step 1 - Obtain a Valid SID
We first need to attempt to enumerate a vlid SID used in the database. For this we will use `nmap` as shown in the section below.
### Nmap
We can use `nmap` to do some simple enumeration on a target which is running Oracle RDMS services as so,
```
root@attacker-machine:~# nmap --script oracle-sid-brute (TARGET IP ADDRESS) -p 1521
```
This relies on the SIDs file `/usr/share/nmap/nselib/data/oracle-sids`. We can upcate this file with more potential SIDs after doing enumertaion of other services during the initial enumeration phase.
## Step 2 - Obtain a Valid Schema
For this step, we will ue the [oscanner](http://www.cqure.net/wp/tools/database/oscanner/) tool.
```
root@attacker-machine:~# oscanner -s (TARGET IP ADDRESS)
```
This will often produce results for us to use as a connection string.
## Connect to Database
THis can be done with [dbeaver](https://dbeaver.io/) or [SQLPlus](https://docs.oracle.com/cd/B19306_01/server.102/b14357/qstart.htm)
