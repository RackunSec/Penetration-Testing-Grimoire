# Custom-Built Tools and Scripts
This readme is for usage on all custom-build tools and scripts used during penetration testing. Copy these tools into your path, e.g.: `/usr/local/bin:/usr/local/sbin` etc, to be called quickly during the penetration test. Remember that accuracy is VERY important, but so is time. These script are meant to save a little time during the penetration test.
## NMAP-Parse-Output
[Tools/nmap-parse-ports.sh](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/nmap-parse-ports.sh) will parse the `nmap` initial scan output for a full port/service discovery scan-worthy CSV.
Usage:

`nmap -v (TARGET IP ADDRESS)`

Then, copy the section like so:

```
21/tcp   open  ftp          syn-ack ttl 128
25/tcp   open  smtp         syn-ack ttl 128
80/tcp   open  http         syn-ack ttl 128
135/tcp  open  msrpc        syn-ack ttl 128
139/tcp  open  netbios-ssn  syn-ack ttl 128
443/tcp  open  https        syn-ack ttl 128
445/tcp  open  microsoft-ds syn-ack ttl 128
1025/tcp open  NFS-or-IIS   syn-ack ttl 128
1026/tcp open  LSA-or-nterm syn-ack ttl 128
1028/tcp open  unknown      syn-ack ttl 128
3372/tcp open  msdtc        syn-ack ttl 128
5800/tcp open  vnc-http     syn-ack ttl 128
5900/tcp open  vnc          syn-ack ttl 128
```

into a file, say, `nmap.init` and then, simply run the tool as so.

```
root@kali:~#nmap -v (TARGET IP ADDRESS)
...
SNIPPED
...
21/tcp   open  ftp          syn-ack ttl 128
25/tcp   open  smtp         syn-ack ttl 128
80/tcp   open  http         syn-ack ttl 128
135/tcp  open  msrpc        syn-ack ttl 128
139/tcp  open  netbios-ssn  syn-ack ttl 128
443/tcp  open  https        syn-ack ttl 128
445/tcp  open  microsoft-ds syn-ack ttl 128
1025/tcp open  NFS-or-IIS   syn-ack ttl 128
1026/tcp open  LSA-or-nterm syn-ack ttl 128
1028/tcp open  unknown      syn-ack ttl 128
3372/tcp open  msdtc        syn-ack ttl 128
5800/tcp open  vnc-http     syn-ack ttl 128
5900/tcp open  vnc          syn-ack ttl 128
...
SNIPPED
...
root@kali:~# nmap-parse-ports.sh nmap.init
21,25,80,135,139,443,445,1025,1026,1028,3372,5800,5900
root@kali:~# nmap -A -p 21,25,80,135,139,443,445,1025,1026,1028,3372,5800,5900 (TARGET IP ADDRESS)
```
