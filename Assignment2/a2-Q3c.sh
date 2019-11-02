#! /bin/bash

#Felix Sam
#CMPT471 Assignment 2
#a2-Q3c.sh


echo "--------------------------------------------------------------------------------------"
echo "----------------------------Question 3: Captured datagrams----------------------------"
echo "--------------------------------------------------------------------------------------"

# Select a pair of hosts A and B, one in network net17 and one in network net18. Use
# tracepath6 on A to test the reachability of B. Use the packet analyzing tool tcpdump
# to capture an IPv6 datagram in net17, net18 or net19 which carries the data from
# your tracepath6 request, and capture an IPv4 datagram in net16 which carries an
# IPv6 datagram for the tracepath6. Show the captured datagrams.

#Net17: Host A -> November
#Net18: Host B -> ipv6 may.net8018

#Tested on November
#Run after a2-Q3d.sh

#ipv6 may.net8018
#ipv6 address is fdd0:8184:d967:8018:250:56ff:fe85:d1d8

#run tracepath6 at November
#datagram travels from November to May through 6in4 tunnel in net16 
#tcpdump from a2-Q3d.sh will capture ipv4 datagram
echo "tracepath6 to destination may.net8018 : fdd0:8184:d967:8018:250:56ff:fe85:d1d8"
tracepath6 fdd0:8184:d967:8018:250:56ff:fe85:d1d8
echo
