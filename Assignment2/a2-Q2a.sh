#! /bin/bash

#Felix Sam
#CMPT471 Assignment 2
#a2-Q2a.sh

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

#Tested on April
#Run after a2-Q2b.sh

#Restore client routing table into its original configuration
echo "Restore client routing table to original configuration"
sudo ifdown eth1 > /dev/null 2>&1
sudo ifup eth1 > /dev/null 2>&1
echo

#clear routing cache
echo "Clearing Routing Cache"
sudo ip route flush cache
echo

#Initialize routing cache to destination may.net18
echo "Initialize the routing cache to the destination may: 172.18.1.5"
sudo ip route get 172.18.1.5
echo

#Tracepath before modifying routing table
echo "tracepath before modifying routing table"
tracepath may.net18
echo

#Show routing table before modification
echo "Show Routing table before modifying routing table"
sudo ip route 
echo

#Delete default route : december.net16 (172.16.1.12)
echo "Deleting Default route: december.net16 (172.16.1.12)"
sudo route del default
echo

#Add new default route : january.net16 (172.16.1.1)
echo "Adding new default route to routing table: january.net16 (172.16.1.1)" 
sudo route add default gw 172.16.1.1 eth1 
echo

#Show routing table after adding new default route
echo "Show Routing table after modification"
sudo ip route 
echo

#Send a packet by pinging may.net18
echo "Sending a packet to may.net18 using ping"
ping -c 1 may.net18
echo







