# CeWL Wordlist Generator
Think you are certain of a username but don't have the password as credentials for a web service? [CeWL](https://digi.ninja/projects/cewl.php) can be used to generate wordlists based off of data scraped from URLs. To use `cewl` do the following:

`root@kali:~# cewl 'http://X.X.X.X/site/whatever.html' > whatever.txt`

This will generate the file `whatever.txt` that can be used in a brute-force attack against a target.
