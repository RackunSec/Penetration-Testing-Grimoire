# HTTP GET Parameters
I placed a good starting point file for this type of enumeration/fuzzing in the [Brute Force/wordlists/get_post_params.txt](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Brute%20Force/wordlists/custom/get_post_params.txt) 
## WFuzz
We can use `wfuzz` to fuzz GET paramaters like so,
```
wfuzz -c -z file,fuzz_get_params.txt --sc 200 https://(TARGET HOST)/file.php?FUZZ=lolhi
```
The `FUZZ` keyword tells WFuzz where to "fuzz" the input. You will get a set of numbers, like so,
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
We use this as our "control" response. The length of the response `L` (for lines) is 0. Now, we can filter these false positives out using the filter sytax like so,
```
wfuzz -c -z file,fuzz_get_params.txt --filter "l>0" https://(TARGET HOST)/file.php?FUZZ=lolhi
```
This will filter out all responses that match a typical (conrtol) response.

## Example
Use the following PHP code as an example:
```
<?php
	if ($_GET['dddid'] == "lolhi"){
		echo "Permissions Granted.";
	}else{
		echo "Halt.";
	}
?>
```
We do not know if the application requires any inpit, because we simply see "Halt." each time we visit the page. 
If we run WFuzz against this page using our wordlist we can see that `W` (for words) is equal to 1, like so,
```
root@demon2:/infosec/www/wfuzz# ./wfuzz -c -z file,/root/fuzz_get_params.txt http://127.0.0.1/file.php?FUZZ=lolhi

********************************************************
* Wfuzz 2.4.6 - The Web Fuzzer                         *
********************************************************

Target: http://127.0.0.1/file.php?FUZZ=lolhi
Total requests: 1570

===================================================================
ID           Response   Lines    Word     Chars       Payload
===================================================================

000000002:   200        0 L      1 W      5 Ch        "bid"
000000003:   200        0 L      1 W      5 Ch        "cid"
000000006:   200        0 L      1 W      5 Ch        "fid"
000000007:   200        0 L      1 W      5 Ch        "gid"
000000008:   200        0 L      1 W      5 Ch        "hid"
000000009:   200        0 L      1 W      5 Ch        "iid"
000000001:   200        0 L      1 W      5 Ch        "aid"
```
We can use WFuzz to try to determine the HTTP GET parameter like so,
```
./wfuzz -c -z file,/root/fuzz_get_params.txt --filter "w>1" http://127.0.0.1/file.php?FUZZ=lolhi
```
And we see the following,
```
********************************************************
* Wfuzz 2.4.6 - The Web Fuzzer                         *
********************************************************

Target: http://127.0.0.1/file.php?FUZZ=lolhi
Total requests: 1570

===================================================================
ID           Response   Lines    Word     Chars       Payload
===================================================================

000000056:   200        0 L      2 W      20 Ch       "dddid"

Total time: 5.147543
Processed Requests: 1570
Filtered Requests: 1569
Requests/sec.: 304.9998

```
# HTTP POST Parameters
We can do the exact same method to fuzz for a POST parameter as we did for the GET paramater above, but with the `-d` (similar to `curl`'s implementation to FUZZ for a POST parameter using WFuzz like so,
```
./wfuzz -c -z file,/root/fuzz_get_params.txt --filter "w>1" -d "FUZZ=lolhi" http://127.0.0.1/file.php
```
## Example
Chaneg your PHP code to be something like so,
```
<?php
	if ($_POST['dddid'] == "lolhi"){
		echo "Permissions Granted.";
	}else{
		echo "Halt.";
	}
?>
```
Next, use the WFuzz tool with our wordlist (just as we did above with the GET parameter) like so,
```
./wfuzz -c -z file,/root/fuzz_get_params.txt --filter "w>1" -d "FUZZ=lolhi" http://127.0.0.1/file.php

********************************************************
* Wfuzz 2.4.6 - The Web Fuzzer                         *
********************************************************

Target: http://127.0.0.1/file.php
Total requests: 1570

===================================================================
ID           Response   Lines    Word     Chars       Payload
===================================================================

000000056:   200        0 L      2 W      20 Ch       "dddid"

Total time: 5.153856
Processed Requests: 1570
Filtered Requests: 1569
Requests/sec.: 304.6262

```
