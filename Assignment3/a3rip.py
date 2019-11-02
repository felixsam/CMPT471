#Felix Sam
#CMPT 471 Assignment 3 Part 2
#a3rip.py

######################################################
#################### Router Class ####################
######################################################
class Router:

	#initialize router with router name and router id
	def __init__(self, name, id):
		#name of router
		self.name = name

		#id number of router
		self.id = id

		#create empty list for neighbours of the router
		self.neighbours = []

		#length of routing table
		self.length = 0

		#dest nextHop dictionary
		self.dest_nextHop = {}

		#dest hops dictionary
		self.dest_hops = {}

	#to hold destination key and corresponding nexthop router value
	def set_dest_nextHop(self,dest,nxtHop):
		self.dest_nextHop[dest] = nxtHop

	#to hold destination key and corresponding hops value
	def set_dest_hops(self,dest,hops):
		self.dest_hops[dest] = hops

	#set neighbour of router
	def set_neighbour(self,neighbour):
		#append neighbour to the list
		self.neighbours.append(neighbour)

	#Prints the routing table of the router
	def routing_table(self):
		print '--------------------------------------------'
		print '------- Routing table for Router ' + str(self.name) + ' -------'
		print '--------------------------------------------'
		print "Dest\t  Next-Hop Router\tHops"
		for key in self.dest_nextHop:
			print str(key) + "\t\t" + str(self.dest_nextHop[key]) + "\t\t  " + str(self.dest_hops[key])
		print 

	#updates the routing table given a routing table from router B
	def update_table(self,routerB):
		for key_B in routerB.dest_hops:
			#get the value for hops in RouterB
			hops_B = routerB.dest_hops[key_B]
			#get the value for next hop router in Router B
			next_hop_B = routerB.dest_nextHop[key_B]

			#Case 1
			#For a destination N in Ta, 
			#if Tb contains a shorter route to N then A updates Ta to have B as the next hop router
			#changes distance to N accordingly
			if key_B in self.dest_hops:
				hops_A = self.dest_hops[key_B]
				#Tb has shorter route to N
				if ( (hops_B + 1) < hops_A):
					#A updates Ta to have B as the next hop router
					self.dest_nextHop[key_B] = str(routerB.name)
					# A changes distance to N in Ta accordingly 
					self.dest_hops[key_B] = (hops_B + 1) 

			#Case 2
			#If Tb contains a route to a destination N which does not have an entry in Ta
			#then A creates an entry for N in Ta and filles in the routing information for N in the entry
			elif key_B not in self.dest_hops:
				#have B as next hop router
				self.set_dest_nextHop(key_B,str(routerB.name))
				#update hops for N
				self.set_dest_hops(key_B,hops_B+1)
				#New entry: increase length of routing table A by 1 
				self.length += 1

			#Case 3
			#For a destination N in Ta with the next hop router B, if Tb shows that the distance from B to N has changed
			# then A updates the distance to N in Ta accordingly
			else:
				for key_A in self.dest_nextHop:
					#next hop router is router B
					if (self.dest_nextHop[key_A] == str(routerB.name)):
						#if Tb shows that distance from B to N has changed
						if (self.dest_hops[key_A] + 1 != routerB.dest_hops[key_A]):
							#A updates distance to N in Ta accordingly
							self.dest_hops[key_A] = routerB.dest_hops[key_A] + 1

######################################################
#################### RIP Protocol ####################
######################################################

################# Setup #####################

#array to hold the 7 routers
routers = []

#create 7 routers for RIP
for i in range(1,8):
	#Router name is Ri for i = 1 to i = 7
	routername = 'R' + str(i)
	router_to_add = Router(routername,i)
	#add the router to the array
	routers.append(router_to_add)

#set neighbours to router
for i in range (len(routers)):
	#add previous router as neighbour if not R1
	if (routers[i].id != 1):
		routers[i].set_neighbour(routers[i-1])
	#add next router as neighbour if not R7
	if (routers[i].id != 7):
		routers[i].set_neighbour(routers[i+1])

# Setting the destination next hop router, and hops to the routing table of Ri 
# for directly connected networks Ni and Ni+1
# for i = 1 to i = 7
for i in range (len(routers)):
	#Set Ni directly connection to Ri
	# i = 1 to i= 7
	key1 = 'N'+str(i+1)
	routers[i].set_dest_nextHop(key1,'R'+str(i+1))
	routers[i].set_dest_hops(key1,1)
	routers[i].length += 1

	#Ni+1 directly connected to Ri
	# i = 1 to i= 7
	key2 = 'N' + str(i+2)
	routers[i].set_dest_nextHop(key2,'R'+ str(i+1))
	routers[i].set_dest_hops(key2,1)
	routers[i].length += 1


# print Initial routing table
print '*************************************************'
print '------------ Initial Routing tables: ------------'
print '*************************************************'
print 
for i in range (len(routers)):
	routers[i].routing_table()
print 


############### Rip Protocol #################
print '*************************************************'
print '--------------- RIP Protocol ---------------'
print '*************************************************'
#Routing tables converge when the length of the routing table for the first router has all entries Ni
while (routers[0].length != 8):
	for i in range (0,7):
		print 'Name of current router is ' + routers[i].name
		print 'Sending routing table updates to its neighbours'
		print 

		#update the routing table of the neighbours against the current routing table
		for neighbour in routers[i].neighbours:
			neighbour.update_table(routers[i])
			print 'Updated routing table: ' + str(neighbour.name)
			neighbour.routing_table()
	print 

print
print 
print '*************************************************'
print '------- Final Routing tables after RIP: -------'
print '*************************************************'
print 
#Final routing table after all tables converge
for i in range (len(routers)):
	routers[i].routing_table()


