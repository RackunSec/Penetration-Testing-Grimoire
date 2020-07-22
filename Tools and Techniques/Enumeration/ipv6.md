# IP Version 6
We can get the IPV6 information by starting with `ping`. Since we are on the same subnet of the machines we attack in Hack the Box, we can ping the machine with,
```
root@attacker-machine:~# ping (TARGET IP ADDRESS)
root@attacker-machine:~# arp -a
? (TARGET IP ADDRESS) at (TARGET MAC ADDRESS) (LOCAL ETHERNET NIC)
```
Now, we have the MAC Address used by the target system. Let's chnage the MAC address into the IPV6 Address
1. split the 6 bytes up into 3 groups of two bytes as so,
```
01:23:45:67:89:01
0123:4567:8901
```
Next, we prepend the `fe08::` portion to the address,
```
fe08::0123:4567:8901
```
Then, we split the middle 2 bytes with `ff:fe` as so,
```
fe08::0123:45ff:fe67:8901
```
Finally, we invert the sixth but of the sixth byte. In our case, the sixth byte is `01`, which in binary, reads, 
```
0000 0001
```
Flip the sixth bit, this now becomes, 
```
0000 0101
```
Which now reads `5`. we replace the sixth byte, `01`, with `05`, 
```
fe08::0523:45ff:fe67:8901
```
To test the validity, get the ethernet device name, in my case is `ens33` for the VMWare virtual device. Then, append it with a percent symbol and use `ping6` as so,
```
root@attacker-machine:~# ping6 fe08::0523:45ff:fe67:8901%ens33
PING fe08::0523:45ff:fe67:8901 (fe08::0523:45ff:fe67:8901) 56 data bytes
```
Because a socket is defined as (IP ADDRESS):(PORT), to browse to an IPV6 afddress, you need to place the entire address into square brackets, like so,
```
http://[fe08::0523:45ff:fe67:8901]
```
