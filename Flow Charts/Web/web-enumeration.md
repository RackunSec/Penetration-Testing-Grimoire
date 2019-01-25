# Web Service Enumeration Flow Chart
Let's draw out recommended steps to take when we find a web service on a target system during CTF, or penetration testing. This can be found via NMAP scans or otherwise. I have anothewr file with tool-specific details [listed here](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Enumeration/HTTP/http-enumeration.md) that I recommend reading as well.
### Edit the /etc/hosts File
Setting the hostname with the IP address will allow you to make HTTP requests with the hostname to the target system. This is used in enumerating any virtual hosts / domains that the target system may be hosting. A single IP address can hosts many web sites by handliong the incoming HTTP request information and mapping the hostname to an area on the file system.

Edit the /etc/hosts file as so,
```
(TARGET IP ADDRESS)      (TARGET HOSTNAME)
E.g.:
10.10.10.10     somehost.somedomain
10.10.10.10     subdomain.somehost.somedomain
```
## 1. Browse to the Web App
First, go to the service using a web browser and view it with eyeballs/or if impaired using a text browser or `curl`. This will often present clues to frameworks or other services that may be employed by the target system. Remember, that during the enumertaion phase of any service, **leave no stone unturned.**
### View Page Sources
There are a few different ways to inspect a web application / web page.
1. Hit CTRL+U and analyze the source code of then entire rendered page.
2. Right click and inspect elements
This can often lead to clues as to the development process, leak info in comments, or, very rarely, leak credentials.
### Developer Tools
Hit F12 to enter the developer tools.
1. Look at the resources that are being accessed by the web site/web app.
2. Refresh the page and watch the network tab to view any extra, potentially unrendered, content.
### Look for Login Pages
If the web application has a login page. This can often lead to a foothold during the penetration test. Especially if we can find an administrative account.
#### SQL Injection Attempt
Tryin a few simple SQL Injection attempts on the page.
1. [Common SQL Injection techniques for login pages](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Vulnerabilities/Web/sql-injection-login-page.md)
2. Commonly used credentials
    1. admin:admin
    2. admin:
    3. admin:default
    4. admin:password
    5. administrator:administrator
    6. administrator:default
    7. administrator:
 #### Brute Force Attacks
 Next, we can try a brute force attack on the login page.
 1. Make sure that you try your best to enumerate a username. If none found, test default usernames such as "admin", "administrator", etc.
 2. Brute force attacks are lengthy. Run them in parallel to your work.
 3. Brute force attacks are lengthy. Try your best to enumerate words from the web aplpication to use as ammunition in the BF attack. Follow the [Generate Wordlists](#Generate_Wordlists) section below.
 ## 2. Scan the Web App
 Next, we will use a few tools to simply scan the web application.
 ### Nikto
 Nikto will provide information about the web service and web application. This scan may also provide use with very obvious web vulnerabilities for both a well.
 ```
 root@attacker-system:~# perl /infosec/www/nikto/program/nikto.pl -h (TARGET URL)
 ```
 ### DIRB
 A great way to enumerate files on the web server is to using a scanning tool such as DIRB. This tool should be used to scan for all suspected web application programming language types. E.g.: if the server is Apache, try PHP extensions for all file names in the DIRB common.txt wordlist.
 ```
 root@attacker-system:~# dirb http://(TARGET IP ADDRESS) -X .php
 ```
 1. Try many different wordlists besides the default `common.txt` wordlists. I have provided some here in this Grimoire, but you should also test some from the [SecLists/Discovery/Web-Content](https://github.com/danielmiessler/SecLists/tree/master/Discovery/Web-Content) area as well.
 2. Also, try common used extensions and web service extensions. You also want to search for development archives or backups. 
    1. .config
    2. .cfc
    3. .jar
    4. .txt
    5. .zip
 3. Search for commonly used framework files, such as license.txt, readme.html, etc.
 ## 3. Generate Wordlists
 Using tools such as CeWL against the target web application and it's content can provide data that we can use to target credentials and brute-force style enumeration techniques.
```
root@attacker-system:~# ruby cew.rb http://(TARGET IP ADDRESS)/
CeWL 5.2 (Some Chaos) Robin Wood (robin@digi.ninja) (https://digi.ninja)
PwnLab
Intranet
Image
Hosting
... (SNIPPED) ...
```
These words work great against attempting a password brute force attack on the target server.
## 4. Check for Service Vulnerabilties
You can find the version of the web application server using 404 pages, HTTP headers, etc. For instance, we can see the version in the VulnHUB.com PwnLab instance by hitting http://(TARGET IP ADDRESS)/lol and view the following,
```
Apache/2.4.10 (Debian) Server at (TARGET IP ADDRESS) Port 80
```
We can also see this version in the HTTP response headers as,
```
Server: Apache/2.4.10 (Debian)
```
By right clicking in our browser on the site, choosing inspect element, clicking the Network tab and refreshing the page. Then select the index file in the bottom panel and view the headers on the right side of the developer tools box.

Use this version number to search exploit resources, such as [exploit-db.com](exploit-db.com) for known vulnerabilties.
## 5. OWASP Top 10 Project
Next, we want to attempt any of the (OWASP top 10)[https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project] web vulnerabilties for each input handler found on the web application.
1. [DotDotPwn](https://github.com/wireghoul/dotdotpwn) to attempt directory traversal
```
root@attacker-system:~# dotdotpwn -h (TARGET IP ADDRESS) -m http
```
2. [SQLMap](http://sqlmap.org/) can be used to test advanced SQL Injection
3. ...
