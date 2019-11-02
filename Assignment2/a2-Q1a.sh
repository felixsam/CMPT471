#! /bin/bash

#Felix Sam
#CMPT471 Assignment 2
#a2-Q1a.sh

echo "--------------------------------------------------------------------------------------"
echo "-----------------------Question 1: ICMP destination unreachable-----------------------"
echo "--------------------------------------------------------------------------------------"

# Question 1
# Use the packet analyzing tool tcpdump 
# to capture an ICMP destination unreachable
# message from one of the four networks 172.x.0.0/16 
# and show the captured message.

#Tested on October
#Run after a2-Q1b.sh

#ping non-existing host to get Destination Host Unreachable
#tcpdump from a2-Q1b.sh will capture ICMP destination unreachable message
echo "Pinging an unreachable host"
ping -c 1 172.16.1.20
echo
