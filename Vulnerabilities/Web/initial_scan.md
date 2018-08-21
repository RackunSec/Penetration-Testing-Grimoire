# Initial Scan for Web Vulnerabilties
This cheat sheet will contain all of the steps I take for each penetration test to identify any web application vulnerabilties on the target server. The first step taken is to scan the web server for vulnerabilties and files and directories.
## Dirb
Directory Buster - brute forces directories and file names on the server.
## Nikto2
Run a Nikto2 Scan. This will attempt to identify any known web service and application vulnerabilties.
## BURP SUITE CE
Using the BURP Suite to identify user input and output from a web aplpication is a necessity.
## SQLMap
SQLMap can be used to attempt to gain access to the back-end databases being used by any web application. This works by verifying tha the user input is, or is not, validated by the web application before sending it as query data to the database.
## SearchSploit
This command will return any known exploits for any discovered web applications.

`root@kali:~# searchsploit "(string)"`
