# WORDPRESS
[Wordpress](https://wordpress.org) is a content management system, CMS, commonly used for web logs. It has an open source community of developers for plugins that can often be used during a penetration test to gain access to a system.
## WPScan
[WPScan]() - is a great tool, designed specifically for Wordpress scanning and vulnerability assessment, to automate scanning of Wordpress sites.
### Initial Scan
The initial scan is done simply by creating a wordpress-content directory to store files in and starting `wpscan` by passing in the URL as so,
```
root@attacker:~# wpscan --url http://192.168.233.172/wordpress/ --wp-content-dir wp-content

[+] URL: http://192.168.233.172/wordpress/
[+] Started: Thu Jan  3 11:31:27 2019

Interesting Finding(s):

[+] http://192.168.233.172/wordpress/
 | Interesting Entry: Server: Apache/2.4.10 (Debian)
 | Found By: Headers (Passive Detection)
 | Confidence: 100%

[+] http://192.168.233.172/wordpress/xmlrpc.php
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%
 | References:
 |  - http://codex.wordpress.org/XML-RPC_Pingback_API
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_ghost_scanner
 |  - https://www.rapid7.com/db/modules/auxiliary/dos/http/wordpress_xmlrpc_dos
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_xmlrpc_login
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_pingback_access

[+] http://192.168.233.172/wordpress/readme.html
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%

[+] Upload directory has listing enabled: http://192.168.233.172/wordpress/wp-content/uploads/
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%

... (SNIPPED) ...

[+] Finished: Thu Jan  3 11:31:29 2019
[+] Requests Done: 41
[+] Cached Requests: 3
[+] Data Sent: 8.56 KB
[+] Data Received: 129.981 KB
[+] Memory used: 52.836 MB
[+] Elapsed time: 00:00:01
```
### Username Enumeration
We can use WPScan to enumerate users as so, 
```
wpscan -e u --url http://192.168.233.172/wordpress/ --wp-content-dir wp-content
```
### 
## Post Exploitation
We can edit certain PHP files to include simple shell exec() calls.
