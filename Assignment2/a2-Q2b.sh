#! /bin/bash

#Felix Sam
#CMPT471 Assignment 2
#a2-Q2b.sh

echo "--------------------------------------------------------------------------------------"
echo "--------------------------Question 2: ICMP Redirect Message---------------------------"
echo "--------------------------------------------------------------------------------------"
# Question 2
# Use the packet analyzing tool tcpdump 
# to capture an ICMP redirect message from
# one of the four networks 172.x.0.0/16; 
# show the captured ICMP redirect messages;
# and show the changes of the routing cache 
# and the routing paths caused by the ICMP
# redirect message.

#Tested on June
#Run before a2-Q2a.sh

#tcpdump capture redirect messages only
#'icmp[icmptype] == icmp-redirect' filters tcpdump for ICMP redirect messages
echo "Capture a redirect message using tcpdump"
sudo tcpdump -c 1 -i eth1 'icmp[icmptype] == icmp-redirect'
echo

#show tracepath after tcpdump captures redirect message
echo "tracepath after redirect message"
tracepath may.net18
echo

#Show routing table
echo "Show Routing table after redirect message"
sudo ip route 
echo

#Restore client routing table into its original configuration
echo "Restore client routing table to original configuration"
sudo ifdown eth1 > /dev/null 2>&1
sudo ifup eth1 > /dev/null 2>&1
echo
