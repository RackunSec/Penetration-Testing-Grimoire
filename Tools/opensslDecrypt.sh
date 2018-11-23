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
count=0
for passwd in $(cat $wordlist)
 do 
  let "count++"
  passwd=$(echo $passwd | sed 's/[^0-9A-Za-z]//g') # remove all but alpha/num
  if [[ $passwd != "" ]] # we need an actual password to try
   then # Get the decrypted version:
    result=$(openssl enc -d -$cipher -salt -in $encryptedFile -out opensslDecryptOutput/${passwd}.decrypted -k $passwd 2>/dev/stdout| head -n 1)
    #printf "DBUG: $result\n";
    # openssl enc -d -aes128 -salt -in drupal.txt -out opensslDecryptOutput/drupal.txt.decrypt -k friends | head -n 1
    if [[ $result != 'bad decrypt' ]]; # It wasn't a failure according to openSSL
     then
      printf "[!] Possible Passphrase found: $passwd\n";
      if [[ -f "opensslDecryptOutput/${passwd}.decrypted" ]] # does the file exist?
       then
        stringSearchPassword=$(strings opensslDecryptOutput/${passwd}.decrypted | egrep -i 'password' |wc -l)
        stringSearchUser=$(strings opensslDecryptOutput/${passwd}.decrypted | egrep -i 'user'|wc -l)
        stringSearchDrupal=$(strings opensslDecryptOutput/${passwd}.decrypted | egrep -i 'drupal'|wc -l)
        stringSearchFlag=$(strings opensslDecryptOutput/${passwd}.decrypted | egrep -i 'flag'|wc -l)
        stringSearchRoot=$(strings opensslDecryptOutput/${passwd}.decrypted | egrep -i 'root'|wc -l)
        if [[ $stringSearchDrupal -gt 0 || $stringSearchUser -gt 0 || $stringSearchDrupal -gt 0 || $stringSearchFlag -gt 0 || $stringSearchRoot -gt 0 ]]
         then
          printf "[!] Possible Passwd Found !!\nPASSWD: $passwd\n\n"
        fi
      else
       printf "[!] Could not create a decrypted file. Something went wrong with the input.\n"
       exit 1;
      fi
     fi
    if [[ $result == 'bad magic number' ]]; # the file is not an .enc file.
     then 
      printf "[!] Not an encrypted file. Is this an encoded encrypted file?\n";
      exit 1 # EXIT hard here
    fi
    rm opensslDecryptOutput/${passwd}.decrypted # remove it.
  fi
  if [[ $((count % 1000)) -eq 0 ]]
   then
    printf "[*] $count Passwords tried.\n"
  fi
done
