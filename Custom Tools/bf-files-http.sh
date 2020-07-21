#!/bin/bash
# 2018 WeakNetLabs.com Douglas Berdeaux
# Description: Brute force file names on an (non-indexable) HTTP server
# Usage: ./bfhttp.sh (URL) (/PATH/TO/WORDLIST)
#
if [[ "$2" == "" ]] # nothing passed
 then
  printf "Usage: ./bfhttp.sh (URL) (/PATH/TO/WORDLIST)"
  exit 1
fi

url=$1
wordlist=$2
count=0
while read word
 do
  let "count++"
  if ! (($count % 100))
   then
    printf "[*] $count Files Tried.\n"
  fi
  resp=$(curl -I -s $url$word | head -n 1)
  if [[ ${resp} != "" ]] && [[ ${resp} != *"404"* ]]
   then
    printf "[!] $word: $resp\n"
  fi
done < $wordlist
