# Host Discovery
The first step to attack your VM for any CTF challenge is to discover the IP address of the VM. Once the VM has completed booting up, use `nmap` to search for all new machines that have a DHCP lease.

`root@kali:~# nmap -sP 192.168.1.1-255`
