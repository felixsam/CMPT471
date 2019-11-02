#Felix Sam
#CMPT 471 Assignment 3 Part 1
#a3server.py

import sys
import socket 

#Host is April
HOST = '172.16.1.4'
#Port is 9999
PORT = 9999

#Create a TCP/IP socket
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

#bind server to port
server.bind((HOST,PORT))
#Listen for a connection
print 'Waiting for a connection'
server.listen(1) 

#open connection between server and client
connection, client = server.accept()


print 'Connection with ', client

while True:
	print 'Receiving Data and retransmitting it to client'
	data = connection.recv(1024)
	print 'Received', repr(data)
	if data:
		#send back data to client
		connection.sendall(data)
	else:
		#no more data to receive
		#break the loop
		break

# Clean up the connection
print 'Closing Connection'
connection.close()
