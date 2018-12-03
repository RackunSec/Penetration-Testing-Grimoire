# HTTP File Enumeration
For web servers that do not allow indexing of the directories, you can easily brute force file names for any fresponse code that is not 404 (not found) or empty responses.

NOTE: I do not recommend making the process confusing as it really is that simple. Stay away from old fashioned, dependency-hell tools, like `gobuster` or `dirbuster` and stick with simple scripts that you can make on your own, or, even better, a lightweight and fast C program, like `dirb`.

## Tools

### DIRB
[DIRB](http://dirb.sourceforge.net/) is a lightweight, fast-scanning tool written in C.

### Custom Scripts
I created a custom script that simply calls `curl` over a wordlist to avoid an ERROR EMPTY RESPONSE for a CTF server that would only return anything when a file actually existed. It can be found here: [*Tools/bfhttp.sh*](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Tools/bfhttp.sh)

## Wordlists
An HTTP file brute-force attack is only as strong as it's input which, in most cases, is a wordlist. I offer a few wwordlists in this repository, but it's best to have as many as possible. My advice is to start building one and make sure that each line in it is unique. One tool you can use to build a word list from data on a target's web site is with the tool [CeWL](https://digi.ninja/projects/cewl.php).

### CeWL
CeWL can be used to create wordlists to be used against the target.
