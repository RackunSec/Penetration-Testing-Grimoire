# Cracking Password Protected Archives
In this cheat sheet, we will find syntax of how to use various tools and techniques for crackling the password of an archived (zipped, or compressed) file. 
## 7z Archive Files
John the Ripper can be a useful tool when tryting to crack the password used when created a zipped 7z archive file. We can crack a 7z file password using a dictionary file. This will require a few things to be installed.
* [John The Ripper (JUMBO)](https://github.com/magnumripper/JohnTheRipper)
* LZMA
* LibLZMA-dev
* Python
Once we have these dependencies installed (Already done in WeakNet LINUX update 8), we can use `7z2john.py` to break the hash out of the protected 7z file using the following command syntax,
```
root@attacker-machine:~# john zapper_backup-hash.txt --wordlist=/path/to/rockyou.txt
Using default input encoding: UTF-8
Loaded 1 password hash (7z, 7-Zip [SHA256 256/256 AVX2 8x AES])
Cost 1 (iteration count) is 524288 for all loaded hashes
Cost 2 (padding size) is 11 for all loaded hashes
Cost 3 (compression type) is 2 for all loaded hashes
Will run 2 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
```
## Zip Files
Zip files can be cracked using the [FcrackZip](https://github.com/hyc/fcrackzip) utility. 
```
root@attacker-machine:~# fcrackzip -v -D -u -p /path/to/rockyou.txt secret.zip
```
