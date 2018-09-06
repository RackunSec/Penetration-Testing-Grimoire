# Initial Host Discovery and Fingerprint Scans
This cheat sheet should be used as a guidline for host discovery and sevice fingerprinting during the penetratino tests.

## Host Scan / Discovery Methodology
Below are the enumeration steps that should be taken on every system during the penetration test. These steps can be adjusted according to the penetration test type, black box/etc.

### Scan the device for services:
1. [__Nmap__](https://github.com/weaknetlabs/OSCP-tools/blob/master/Enumeration/nmap-port-scanning.md) - Perform an [NMAP](https://www.nmap.org) scan with service enumeration enabled.

### Scan for shares and WINDOWS data:
1. [__NBTScan__](http://www.unixwiz.net/tools/nbtscan.html) look for open shares on the target 
2. [__Enum4Linux__](https://github.com/portcullislabs/enum4linux) look for data from Windows hosts and LINUX Samba hosts

### Web Services / Apps
1. [__Nikto__](https://cirt.net/Nikto2) scan for vulnerabilities
2. Browse to them and poke around for vulnerabilities
  * Use Developer Tools in Chrome or Firefox
  * Use BURP Suite Community Edition for input data analysis
3. [__SQLMap__](https://github.com/weaknetlabs/OSCP-tools/blob/master/Vulnerabilities/Web/SQLMap.md) scan if any GET or POST input was found in the manual tests
4. [__Dirb__](https://tools.kali.org/web-applications/dirb) - Use the `dirb` tool to quickly scan for content on a web server. This could reveal test directories, vulnerable web application files, backups of web applications and files, and more.
