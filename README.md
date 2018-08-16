# OSCP-tools
Custom Tools and Notes from my OSCP PWK experience

## Recon Tools
* *Robots.txt.test.sh* - This tool will grab the robots.txt file and run through each entry to display the HTTP status of the file.
  * Run with `chmod +x robots.txt.test.sh && ./robots.txt.test.sh`
* *ntlm-bf.sh* - This tool will loop through a text file and try every password with the username of "admin"
  * Run with `chmod +x bf.sh && ./bf.sh (URI) (PATH TO WORD LIST)`
