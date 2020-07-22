# ICMP OS Enumeration
Sometimes it is possible to determine what operating system a target is running using the ICMP protocol and analyzing the ICMP responses from the target server. We can do this with the iputils-ping utility, `ping` like so,
```
root@attacker-machine:~# ping $TARGET
64 bytes from $TARGET: icmp_sec=1 ttl=63 time=68.1 ms
64 bytes from $TARGET: icmp_sec=2 ttl=63 time=55.7 ms
64 bytes from $TARGET: icmp_sec=3 ttl=63 time=97.2 ms
... (SNIPPED) ...
```
We can see this is a LINUX system as the TTL was returnred as `63`. Micrososft Windows ICMP TTL responses will be 128 and LINUX is 64. 63 means that there is a hop between the attack-machine and the target, or 128-63 hops between the attacker-machine and the target (less likely in a lab).
