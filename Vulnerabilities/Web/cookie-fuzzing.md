# Cookies and Fuzzing
We can use the Firefox plugin, [Cookie Quick Manager](https://addons.mozilla.org/en-US/firefox/addon/cookie-quick-manager/)  to analyze and set cookies.

For instance, say that a web application has a particular cookie vulnerabiltiy that we can manage using the browser's plugin, like so,
```
<?php 
 if(isset($_COOKIE['lang']){
  include("lang/".$_COOKIE['lang']);
 }
 ... (SNIPPED) ...
```
Just by looking at that code, we can see the vulnerability of local file inclusion. If we set our Cookie as so,
```
Cookie: lang=../../../../../../../../../etc/passwd
```
Then the file, `/etc/passwd` will be included on the page. Depeneding on what the DOM and styling is set to, we may have to inspect the source to view the Base-64 encoded output. Then, we can simply copy this string and echo it into the terminal to decode it like so,
```
root@attacker-machine:~# echo -n "(BASE64 ENCODED OUTPUT FROM ABOVE EXPLOIT)" | base64 -d
```
And we will be able to view the contents of any file.
