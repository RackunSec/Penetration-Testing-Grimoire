# Impersonataion Attacks with LLMNR
We can use the tool `Responder.py` to "respond" to all discoverey queries for multiple protocols. 
## LLMNR
Local-link multicast name resolution. The Link-Local Multicast Name Resolution (LLMNR) is a protocol based on the Domain Name System (DNS) packet format that allows both IPv4 and IPv6 hosts to perform name resolution for hosts on the same local link. It is included in Windows Vista, Windows Server 2008, Windows 7, Windows 8 and Windows 10.
### Discovery
Once on the target network, we can start Wireshark with the libpcap filter `llmnr` to filter LLMNR traffic. If any is discovered, the network may be vulnerable to this type of impersonation attack.
