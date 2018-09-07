#!/bin/bash
# 2018 DOuglas Berdeaux WeakNetLabs.com
# Pass to me the URL:
# e.g.:
# ./robots.txt.test.sh http://10.10.0.22
#
wget $1/robots.txt
for url in $(for uri in $(awk '{print $2}' robots.txt |egrep '^/'); 
 do 
  echo $1$uri; 
 done); 
 do curl -o /dev/null  --silent --head --write-out '%{url_effective}:%{http_code}\n' $url; 
done
