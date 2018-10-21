#!/bin/bash
# PHP GET Parameter fuzzing / BF
# Search for new pages, files, database entries, etc
# 1. Find specific string the page returns when you pass a non existent param.
#   e.g.: "Not Found"
# ./php_get_bf (WORDLIST FILE) (URL) (ERROR MSG)
#   Use an asterisk * to denote the fuzz/bf point.
# Example:
# ./php_get_bf /wordlists/rockyou.txt http://somesite.site/blog.php?topic=* "404 Not Found"
# 
# Douglas Berdeaux (WeakNetLabs@Gmail.com)
#
wordlist=$1
uri=$2
error=$3
function usage {
 printf "Usage: ./php_get_bf.sh (WORDLIST) (URI WITH '*' FUZZ POINT) (ERROR/404 STRING)\n"
 exit
}
# Let's check the arguments:
if [ "$#" -lt 2 ]; then
 usage;
fi
# Did the URI have an asterisk?
if ! [[ $uri =~ \* ]]; then
 printf "You MUST include an injection point in your URI as '*'\n"
 usage;
fi
#COOKIE=$4 # Cookies can be easily added: --cookie "$COOKIE" into the curl call below
for string in $(cat $wordlist);
 do
  uriInterpol=$(echo $uri | sed s/*/$string/) # replace the "*" with the string fomr the dictionary file.
  # Make the response a single string using sed trick, then grep -v for the error or unwanted/404 response:
  curl -s "$uriInterpol" | sed ':a;N;$!ba;s/\n/ /g' | sed -r 's/\s+//g' | grep -v $error;
  #echo $uriInterpol # DEBUGGING
 done
# EOF
