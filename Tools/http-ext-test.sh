#!/bin/bash
# 2019 Douglas Berdeaux - WeakNet Labs, Demon Linux
# Pass a URL to me.
usage () {
 printf "[!] Usage: ./http-test-ext.sh (URL)\n"
 exit;
}
if [[ "$1" == "" ]];then
 printf "[!] No argument given.\n"
 usage;
fi
url=$1
url=$(echo $url|sed -re 's/\/$//g')
printf "[*] Testing URL: $url\n";
extensions=( "aspx" "asp" "php" "php5" "conf"\
 "txt" "html" "htm" "swf" "java" "jsp" "xml"\
 "do" "cfm" "jar" "pl" "py" "rb" "rhtml" "rss" "cgi" )
for ext in ${extensions[@]}; do
 printf "[*] Testing: $ext ... ";
 resp=$(curl -s -I ${url}/index.${ext}|head -n 1 | awk '{print $2}')
 if [[ "$resp" -eq 200 ]]; then
  printf "worked! \n[!] Extension found! - $ext\n";
  exit
 else
  printf "failed.\n"
 fi
done
printf "[*] Scan completed.\n"

