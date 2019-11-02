#! /bin/bash

#Felix Sam
#CMPT471 Assignment 2
#a2-Q3b.sh


echo "--------------------------------------------------------------------------------------"
echo "----------------------------Question 3: Captured datagrams----------------------------"
echo "--------------------------------------------------------------------------------------"

# Select a pair of hosts A and B, one in network net17 and one in network net18. Use
# tracepath6 on A to test the reachability of B. Use the packet analyzing tool tcpdump
# to capture an IPv6 datagram in net17, net18 or net19 which carries the data from
# your tracepath6 request, and capture an IPv4 datagram in net16 which carries an
# IPv6 datagram for the tracepath6. Show the captured datagrams.

#Net17: Host A -> November
#Net18: Host B -> ipv6 may.net18

#Tested on November
#Run before a2-Q3a.sh

#Capture ipv6 datagram sent by tracepath6 from a2-Q3a.sh
#Filter by destination fdd0:8184:d967:18:250:56ff:fe85:d1d8
#can add -X option to print out data of datagram but left option out to improve readability
echo "Capture ipv6 Datagram using tcpdump"
echo 
sudo tcpdump -c 4 -i eth1 ip6 dst fdd0:8184:d967:18:250:56ff:fe85:d1d8
echo 


