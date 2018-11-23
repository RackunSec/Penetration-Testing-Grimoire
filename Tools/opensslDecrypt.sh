#!/bin/bash
# OpenSSL .enc file decryption cracking script
# 2018 WeakNet Labs, Douglas Berdeaux, weaknetlabs@gmail.com
# ./opensslDecrypt.sh (WORDLIST) (FILE TO CRACK) (CIPHER) (MESSAGE DIGEST)
#
#wnl8:~/HTB/ctf-machine# ./opensslDecrypt.sh /pwnt/wordlists/rockyou-full.txt drupal.txt.dec aes-256-cbc sha256
#OpenSSLDecrypt Brute Force Tool.
#[*] Destroying and Creating temporary directory, ./opensslDecryptOutput
#
#[!] Possible Passwd Found !!
#[!] PASSWD: MyPass100
#[*] File Type: opensslDecryptOutput/MyPass100.decrypted: ASCII text
#
# wnl8:~/HTB/ctf-machine#
#
wordlist=$1 # I am renaming these for readability of the code
encryptedFile=$2
cipher=$3
digest=$4
if [[ $4 == "" ]]
 then
   printf "Usage: ./opensslDecrypt.sh (WORDLIST) (DECODED - ENCRYPTED FILE) (CIPHER) (DIGEST)\n"
   exit 1
 fi
printf "\nOpenSSLDecrypt Brute Force Tool.\n\n[*] Destroying and Creating temporary directory, ./opensslDecryptOutput\n\n"
rm -rf opensslDecryptOutput
mkdir opensslDecryptOutput
count=0 # This token is used for UX feedback
while read -r passwd # read the file in by line rather than all into memory causing a kill
 do
  let "count++"
  passwd=$(echo $passwd | sed 's/[^0-9A-Za-z]//g') # remove all but alpha/num
  if [[ $passwd != "" ]] # we need an actual password to try
   then # Get the decrypted version:
    result=$(openssl enc -md $digest -$cipher -d -in $encryptedFile -out opensslDecryptOutput/${passwd}.decrypted -d -pass pass:"$passwd" 2>/dev/stdout| head -n 1)
    if [[ $result != 'bad decrypt' ]]; # It wasn't a failure according to openSSL
     then
      if [[ -f "opensslDecryptOutput/${passwd}.decrypted" ]] # does the file exist?
       then
        resultTest=$(file opensslDecryptOutput/${passwd}.decrypted | grep "ASCII text" | wc -l)
        if [[ $resultTest -eq 1 ]]
         then
          printf "\n[!] Possible Passwd Found !!\n[!] PASSWD: $passwd\n[*] File Type: $(file opensslDecryptOutput/${passwd}.decrypted)\n\n"
          exit
        fi
      else
       printf "[!] Could not create a decrypted file. Something went wrong with the input.\n[*] Error: $result\n\n"
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
    printf "[*] $count Passwords tried. ($passwd:$result)\n"
  fi
done < $wordlist
