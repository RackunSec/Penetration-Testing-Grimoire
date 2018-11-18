#!/bin/bash
# OpenSSL .enc file decryption cracking script
# 2018 WeakNet Labs, Douglas Berdeaux, weaknetlabs@gmail.com
# ./opensslDecrypt.sh (WORDLIST) (FILE TO CRACK) (CIPHER)
wordlist=$1
encryptedFile=$2
cipher=$3
printf "\nOpenSSLDecrypt Brute Force Tool.\n\n[*] Destroying and Creating temporary directory, ./opensslDecryptOutput\n"
rm -rf opensslDecryptOutput
mkdir opensslDecryptOutput
for passwd in $(cat $wordlist)
 do 
  passwd=$(echo $passwd | sed 's/[^0-9A-Za-z]//g') # remove all but alpha/num
 if [[ $passwd != "" ]]
  then
   result=$(openssl enc -d -$cipher -salt -in $encryptedFile -out opensslDecryptOutput/${passwd}.decrypted -k $passwd 2>/dev/stdout| head -n 1)
   if [[ $result != 'bad decrypt' ]];
    then
     stringSearchPassword=$(strings opensslDecryptOutput/${passwd}.decrypted | egrep -i 'password' |wc -l)
     stringSearchUser=$(strings opensslDecryptOutput/${passwd}.decrypted | egrep -i 'user'|wc -l)
     stringSearchDrupal=$(strings opensslDecryptOutput/${passwd}.decrypted | egrep -i 'drupal'|wc -l)
     stringSearchFlag=$(strings opensslDecryptOutput/${passwd}.decrypted | egrep -i 'flag'|wc -l)
     stringSearchRoot=$(strings opensslDecryptOutput/${passwd}.decrypted | egrep -i 'root'|wc -l)
     if [[ $stringSearchDrupal -gt 0 || $stringSearchUser -gt 0 || $stringSearchDrupal -gt 0 || $stringSearchFlag -gt 0 || $stringSearchRoot -gt 0 ]]
      then
       printf "[!] Possible Passwd Found !!\nPASSWD: $passwd\n\n"
      else
       rm opensslDecryptOutput/${passwd}.decrypted # remove it.
     fi
   fi
 fi
done
