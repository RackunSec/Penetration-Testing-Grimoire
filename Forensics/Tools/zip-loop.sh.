#!/bin/bash
# Looping through Protected ZIP files
# for CTF
#
currentZipFile=$1
while [ 1 ];
do
 protectedFileName=$(strings $currentZipFile |egrep '\.zip' | head -n 1 | sed -r 's/\.zip.*/.zip/' )
 if [[ $protectedFileName =~ .zip$ ]]; then
  # We have a protected file, let's get the password:
  potectedFilePassword=$(echo $protectedFileName | sed 's/\..*//') # string the extension
  echo "[*] Unzipping $protectedFileName"
  unzip -P $potectedFilePassword $currentZipFile
  rm $currentZipFile # remove the shell
  currentZipFile=$protectedFileName # updatethe current file
 else
  echo ""
  echo "[!] Name mismatch: $protectedFileName"
  echo "[*] All Done!"
  break
  exit 1
 fi
done
