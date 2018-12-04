#!/bin/bash
#
# Description: Brute force usernames or other internal data relying on the HTTP error response of the login handler.
#  E.G.: An HTTP POST login form that tells you whether or not a username exists:
#   ./userEnum.sh /path/to/usernames.txt http://(TARGET URI)/login.php "No account found with that username"
#
#
# 2018 - WeakNetLabs@Gmail.com
# Douglas Berdeaux
# Usage: ./userEnum.sh (/path/to/wordlist) (URL TO POST) "(Login Error Message)"
#
wordlist=$1
url=$2
errorMsg=$3
userFound=false
printf "Simple HTTP POST login User Enumeration Script.\n"
while read username
 do
 try=$(curl -s --data 'username=admin&password=password' $url | grep "$errorMsg" | wc -l)
 if [[ "$try" < 1 ]] && [[ "$try" != "" ]]
  then
   printf "\n[!] Possible username found: [$username]\n[*] OUTPUT: $response"
   userFound=true
 #else
  #printf "[!] FAILED: $username: $response\n"
 fi
done < $wordlist
if [[ "$userFound" == false ]]
 then
  printf "\n[*] Username not in list provided.\n\n"
fi
