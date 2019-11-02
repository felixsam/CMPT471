#! /bin/bash

#Felix Sam
#CMPT471 Assignment 2
#a2-Q1b.sh

echo "--------------------------------------------------------------------------------------"
echo "-----------------------Question 1: ICMP destination unreachable-----------------------"
echo "--------------------------------------------------------------------------------------"

# Question 1
# Use the packet analyzing tool tcpdump 
# to capture an ICMP destination unreachable
# message from one of the four networks 172.x.0.0/16 
# and show the captured message.

#Tested on April
#Run before a2-Q1a.sh

#use tcpdump to capture a packet with ICMP destination unreachable message
#'icmp[icmptype] == icmp-unreach' filters tcpdump for ICMP destination unreachable 
#a2-Q1a.sh will ping a non-existing ip address for capture
echo "Capturing an ICMP destination unreachble message"
sudo tcpdump -c 1 -i eth1 'icmp[icmptype] == icmp-unreach'
echo