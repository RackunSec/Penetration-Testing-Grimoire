# Cracxking Password Protected 7z Files
Step 1. use 7z2john script in JohnTheRipper Jumbo as,
```
root@attacker:~# /pwnt/passwords/JohnTheRipper/run/7z2john.pl backup.7z > 7z2john.out
```
Then,
 simply run `john` as you normally would for a hash file like so,
 ```
root@attacker:~# /pwnt/passwords/JohnTheRipper/run/john 7z2john.out \
 --wordlist=/pwnt/passwords/wordlists/rockyou.txt 
 
Using default input encoding: UTF-8
Loaded 1 password hash (7z, 7-Zip [SHA256 256/256 AVX2 8x AES])
Cost 1 (iteration count) is 524288 for all loaded hashes
Cost 2 (padding size) is 12 for all loaded hashes
Cost 3 (compression type) is 2 for all loaded hashes
Will run 2 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
delete           (backup.7z)
1g 0:00:01:40 DONE (2019-01-18 09:02) 0.009979g/s 20.59p/s 20.59c/s 20.59C/s slimshady..aries
Use the "--show" option to display all of the cracked passwords reliably
Session completed
 ```
