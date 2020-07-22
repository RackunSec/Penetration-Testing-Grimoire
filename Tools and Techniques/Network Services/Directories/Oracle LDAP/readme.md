# Oracle LDAP
Oracle's implementation of the Lightweight Directory Access Protocol, LDAP, is a directory service similar to Microsoft's Active Directory. This is a simple database that stores user information in a hierarchical structure.
## Terms
Below is a simple list of terms to become familiar with before engaging in a penetration test in which the client has employed an LDAP service.
* LDAP - Lightweight Directory Access Protocol - the protocol used for LDAP service connections, queries, etc.
* OU - Organizational Unit
* LDAPS - LDAP over SSL for encrypting the traffic.
* Port 636 - LDAP over SSL (LDAPS) port that is commonly used (default).
* Port 389 - plain-text, unencrypted, LDAP port commonly used (default).
## Connecting to LDAP
There are many tools that we can use to make connections to LDAP
### LDAPSearch
[ldapsearch](https://docs.oracle.com/cd/E19693-01/819-0997/auto45/index.html) opens a connection to an LDAP server, binds, and performs a search using specified parameters. 
### Apache Directory Studio
[Apache Directory Studio](https://directory.apache.org/studio/) is a complete directory tooling platform intended to be used with any LDAP server however it is particularly designed for use with ApacheDS. It is an Eclipse RCP application, composed of several Eclipse (OSGi) plugins, that can be easily upgraded with additional ones. These plugins can even run within Eclipse itself.
### Pentest Tools
A list of open-source penetration testing tools can also be used to make connections and queries to LDAP including,
* [ldapdomaindump](https://github.com/dirkjanm/ldapdomaindump)
* 
