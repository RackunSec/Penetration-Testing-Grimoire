# Initializing a Test Notes Set
Ask 10 people how they take notes during a penetration test or CTF and you will get 11 different answers. Here is my methodology and you, by no means, are required or obligated to follow it.
1. **Create directory skeleton structure.**
```
~/Penetration Testing
|->./HTB
   |->./(Host Name)
      |->./exploits
      |->./files
```
This is what I will be working with primarly for logs, output files, building exploits, and saving files I find on the target's file system.

2. **Create a new skeleton file in cloud-based notes (available anywhere).**
   2. Create the folowing headings
      * **NOTES**
      * **CREDENTIALS**
      * **NMAP OUTPUT**
      * **DIRB OUTPUT**
      * **NIKTO OUTPUT**
      
 This I will be using for permanent notes which contain how I exploited the system, application output, notes, credentials, and even resources used during the penetration test.
      
 3. **Build from there accordingly as I find new services to enumerate.**
