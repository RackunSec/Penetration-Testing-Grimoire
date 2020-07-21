# HTTP GET Paramaters
I placed a good starting point file for this type of enumeration/fuzzing in the [Brute Force/wordlists/get_post_params.txt](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wordlists/get_post_params.txt) 
## WFuzz
We can use `wfuzz` to fuzz GET paramaters like so,
```
wfuzz -c -z file,fuzz_get_params.txt --sc 200 https://(TARGET HOST)/file.php?FUZZ=lolhi
```
You will get a set of numbers, like so,
```
********************************************************
* Wfuzz 2.4.5 - The Web Fuzzer                         *
********************************************************

Target: https://(TARGET HOST)/file.php?FUZZ=lolhi
Total requests: 1569

===================================================================
ID           Response   Lines    Word     Chars       Payload
===================================================================

000000001:   200        0 L      0 W      0 Ch        "aid"
000000008:   200        0 L      0 W      0 Ch        "hid"
000000009:   200        0 L      0 W      0 Ch        "iid"
000000010:   200        0 L      0 W      0 Ch        "jid"
000000003:   200        0 L      0 W      0 Ch        "cid"
000000002:   200        0 L      0 W      0 Ch        "bid"
```
We use this as our "control" response. The length of the response "L" is 0. Now, we can filter these false positives out using the filter sytax like so,
```
wfuzz -c -z file,fuzz_get_params.txt --filter "l>0" https://(TARGET HOST)/file.php?FUZZ=lolhi
```
This will filter out all responses that match a typical (conrtol) response.
