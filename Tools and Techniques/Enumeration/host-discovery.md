# Host Discovery
The first step to attack your VM for any CTF challenge is to discover the IP address of the VM. Once the VM has completed booting up, use `nmap` to search for all new machines that have a DHCP lease.
## Using NMAP
We can use `nmap` to perform a host discovery scan like so,
```
root@attacker-machine:~# nmap -sP 192.168.1.1-255
```
## Using Ettercap
We can also use `ettercap` to perform a host discovery scan like so,
```
root@attacker-machine:~# ettercap -T -i eth0 ///
```
## Netdiscover
We can use `netdiscover` to search using a specified NIC like so,
```
root@attacker-machine:~# netdiscover -i ens33
```
