#! /bin/bash

#Felix Sam
#CMPT471 Assignment 2
#a2-Q3d.sh


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

#Tested on April
#Run before a2-Q3c.sh

#Capture ipv4 datagram carrying an ipv6 datagram from tracepath6 in a2-Q3c.sh
#use proto41 to filter for ipv4 datagram
#can add -X option to print out data of datagram but left option out to improve readability
echo "Capture ipv4 Datagram using tcpdump"
echo
sudo tcpdump -c 4 -i eth1 proto 41
echo


