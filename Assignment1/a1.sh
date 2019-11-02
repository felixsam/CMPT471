#! /bin/bash

#Felix Sam
#CMPT471 Assignment 1
#a1.sh

#array to hold the names of the 20 client hosts
clients=("summer" "fall" "equinox" "april" "june" "september" "december" "may" "july" "winter" "march" "year" "solstice" "october" "february" "autumn" "november" "spring" "august" "january")

#array to hold suffix for the networks with .net suffix: net16 net17 net18 net19
netsuffix=(".net16" ".net17" ".net18" ".net19")

#store the name of the source host 
sourcehost=$(hostname)

#store the name of the source IP address 
#filter the result of hostname -i to obtain only the IP address 
sourceIP=$(hostname -i | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

echo "--------------------------------------------------------------------------------------"
echo "------------------------Test 1: Use Host names as destinations------------------------"
echo "--------------------------------------------------------------------------------------"

#Use host names as destinations
#for every host in the clients array
#ping the admin host and the net hosts(net16 net17 net18 net19)
#if the ping is successful print out that the client host is reachable from the sourcehost
#else print out that the client host is not reachable from the source host
for i in "${clients[@]}"
do
	echo
	#ping admin hostname for the current client
	#hide output of ping to improve readability
	adminhostname=$i
	if ping -c 1 $adminhostname > /dev/null 2>&1
		then echo "$adminhostname is reachable from $sourcehost"
	else 
		echo "$adminhostname is not reachable from $sourcehost"
	fi
	#use tracepath on the adminhost 
	#hide the result to improve readability
	tracepath $adminhostname > /dev/null 2>&1
	
	#ping the net hostname for the current client(net16 net17 net18 net19)
	#hide output of ping to improve readability
	for k in "${netsuffix[@]}"
	do 
		nethostname=$i$k
		if ping -c 1 $nethostname > /dev/null 2>&1
			then echo "$nethostname is reachable from $sourcehost"
		else 
			echo "$nethostname is not reachable from $sourcehost"
		fi
		#use tracepath on the nethost
		#hide the result to improve readability
		tracepath $nethostname > /dev/null 2>&1
	done
done


echo "--------------------------------------------------------------------------------------"
echo "----------------------Test 2: Use IPv4 addresses as destinations----------------------"
echo "--------------------------------------------------------------------------------------"

echo
#Use IPv4 addresses as destinations
#Ping the ipv4 addresses in the CSIL Networking Lab which has the form 192.168.0.j and 172.n.1.j
#where j is from 0 to 20 as highest is spring (172.17.1.20) for the form 172.n.1.j
#where n is from 16 to 19(for net16 net17 net18 net19)
#If ping is successful then print out that it is reachable from the source host IP address
#Else print out that it is not reachable from the source host IP address
for j in {0..20}
do
	echo

	#ping the admin network ipv4 address
	#hide output of ping to improve readability
	adminipv4="192.168.0.$j"
	if ping -c 1 adminipv4 > /dev/null 2>&1
			then echo "$adminipv4 is reachable from $sourceIP"
		else 
			echo "$adminipv4 is not reachable from $sourceIP"
	fi
	#tracepath the ipv4 address for the admin network
	#hide the results to improve readability
	tracepath $adminipv4 > /dev/null 2>&1

	#ping the ipv4 address for net16 net17 net18 net19
	#hide output of ping to improve readability
	for n in {16..19}
	do 
		netipv4="172.$n.1.$j"
		if ping -c 1 $netipv4 > /dev/null 2>&1
			then echo "$netipv4 is reachable from $sourceIP"
		else 
			echo "$netipv4 is not reachable from $sourceIP"
		fi
		#tracepath the ipv4 address for the net16 net17 net18 net19 networks
		#hide the results to improve readability
		tracepath $netipv4 > /dev/null 2>&1
	done
done


echo "--------------------------------------------------------------------------------------"
echo "----------------------Test 3: Use IPv6 addresses as destinations----------------------"
echo "--------------------------------------------------------------------------------------"

echo
# Use IPv6 addresses as destinations
# Test the reachability of network connection may.net18 from host august
# Uses the two ipv6 ULA address for may.net18

#First ipv6 ULA for may 
mayULA1="fdd0:8184:d967:18:250:56ff:fe85:d1d8"

echo "First IPv6 ULA for may.net18: $mayULA1"

#Second ipv6 ULA for may 
mayULA2="fdd0:8184:d967:8018:250:56ff:fe85:d1d8"

echo "Second IPv6 ULA for may.net18: $mayULA2"

echo
echo "Testing the reachability of network connection may.net18 using the two IPv6 addresses for may"
echo

echo "Pinging the first ULA for may.net18: $mayULA1"


#if ping to the first may.net18 ULA is successful
#print that it is reachable from the source host
#else print that it is not reachable from the source host
#hide output of ping6 to improve readability
if ping6 -c 1 $mayULA1 > /dev/null 2>&1
	then 
	echo "$mayULA1 is reachable from host $sourcehost"
else 
	echo "$mayULA1 is not reachable from host $sourcehost"
fi

echo

#Use tracepath6 on the first ULA for may.net18
echo "Tracepath6 for the first ULA for may.net18: $mayULA1"
tracepath6 $mayULA1

echo

#if ping to the second may.net18 ULA is successful
#print that it is reachable from the source host
#else print that it is not reachable from the source host
#hide output of ping6 to improve readability
echo "Pinging the second ULA for may.net18: $mayULA2"

if ping6 -c 1 $mayULA2 > /dev/null 2>&1
	then 
	echo "$mayULA2 is reachable from host $sourcehost"
else 
	echo "$mayULA2 is not reachable from host $sourcehost"
fi

echo

#Use tracepath6 on the second ULA for may.net18
echo "Tracepath6 for the second ULA for may.net18: $mayULA2"
tracepath6 $mayULA2

echo "--------------------------------------------------------------------------------------"
echo "--------------Test 4: Find the Ethernet addresses of network connections--------------"
echo "--------------------------------------------------------------------------------------"

echo
#Find the Ethernet addresses of network connections

#Use arp to print the ethernet address for the network that hostname is in
#grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' 
#filters the result to provide the Ethernet address XX:XX:XX:XX:XX:XX for each connection in the network
echo "Finding the Ethernet address for each connection in the same network as the host: $sourcehost"
arp -a | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'


