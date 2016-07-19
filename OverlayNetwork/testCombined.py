from TOSSIM import *
from array import *
from tinyos.tossim.TossimApp import *
import random
from RoutMsg import *
import sys
import mcds

#Node class needed to construct a directed graph of network in TOSSIM
class Node(object):
  def __init__(self,idNum,xCord,yCord):
    self.nextNodes = []
    self.idNum=idNum
    self.xCord=xCord
    self.yCord=yCord

#n = NescApp("TestNetwork", "app.xml")
#t = Tossim(n.variables.variables())
t = Tossim([])
r = t.radio()
numNodes = 30
endTime = 6 #seconds

#CLIENT SPECIFICED REGION OF INTEREST (change according to client's preferences)
clientXOne = 20
clientXTwo = 80
clientYOne = 30
clientYTwo = 60

#neded to construct directed graphs (which will show overlaps)
listNodes = []
graph = []
for i in range(numNodes):
  graph.append(Node(-1, 0, 0))

sys.stdout = open('out_testCombined.txt','w')

f = open("combined_topo.txt", "r")
lines = f.readlines()
for line in lines:
  s = line.split()
  if (len(s) > 0):
    r.add(int(s[0]), int(s[1]), float(s[2]))
    valOne = int(s[0])
    valTwo = int(s[1])
    xCordOne = int(s[3])
    yCordOne = int(s[4])
    xCordTwo = int(s[5])
    yCordTwo = int(s[6])
    if valOne not in listNodes:
      graph[valOne] = Node(valOne, xCordOne, yCordOne)
      listNodes.append(int(s[0]))
    if valTwo not in listNodes:
      graph[valTwo] = Node(valTwo, xCordTwo, yCordTwo)
      listNodes.append(int(s[1]))

  graph[valOne].nextNodes.append(valTwo)

noise = open("noise.txt", "r")
lines = noise.readlines()
for line in lines:
  str = line.strip()
  if (str != ""):
    val = int(str)
    for i in range(0, numNodes):
      m = t.getNode(i);
      m.addNoiseTraceReading(val)

#construct graph of nodes and edges in region of interest
graphRegionWithAllEdges = []
nodesInRegion = []
for mote in graph:
  #check if in region of interest
  if (mote.xCord > clientXOne and mote.yCord > clientYOne 
      and mote.xCord < clientXTwo and mote.yCord < clientYTwo): 
    graphRegionWithAllEdges.append(mote)
    nodesInRegion.append(mote.idNum)

#remove edges outside of region of interest
graphRegion = []
for i in range(len(graphRegionWithAllEdges)):
  mote = graphRegionWithAllEdges[i]
  relevantNextNodes = []
  for edge in mote.nextNodes:
    if(edge in nodesInRegion):
      relevantNextNodes.append(edge)
  graphRegion.append(Node(mote.idNum, mote.xCord, mote.yCord))
  for edge in relevantNextNodes:
    graphRegion[i].nextNodes.append(edge)

#print out region of interest nodes and edges to test
for mote in graphRegion:
  print "Node ", mote.idNum, " is connected to:",
  for edge in mote.nextNodes:
    print edge, " ",
  print " "

# Finding MCDS, code loacated in mcds.py
CDSgraph = mcds.findmcds(graphRegion)
CDSgraphIDnums = []
print "MCDS is: "
for node in CDSgraph:
  print node.idNum
  CDSgraphIDnums.append(node.idNum)


for i in range(0, numNodes):
	m = t.getNode(i);
	if(i in CDSgraphIDnums):
		m.createNoiseModel();
		m.bootAtTime(1000 * i + 1);
		print "Booting ", i, " at ", i * 1000 + 1

print "Starting simulation."

#t.addChannel("AM", sys.stdout)
#t.addChannel("TreeRouting", sys.stdout)
#t.addChannel("TestNetworkC", sys.stdout)
#t.addChannel("Route", sys.stdout)
#t.addChannel("PointerBug", sys.stdout)
#t.addChannel("QueueC", sys.stdout)
#t.addChannel("Gain", sys.stdout)
#t.addChannel("Forwarder", sys.stdout)
t.addChannel("AODV", sys.stdout)
t.addChannel("OverlayNetworkC", sys.stdout)
t.addChannel("Flooding", sys.stdout)
t.addChannel("CTP", sys.stdout)
t.addChannel("APPS", sys.stdout)
t.addChannel("Traffic", sys.stdout)
t.addChannel("Universal", sys.stdout)
#t.addChannel("AODV_DBG", sys.stdout)
#t.addChannel("Acks", sys.stdout)

#Declares routing protocol and overlap info for each node
#routing 1 = CTP
#routing 2 = AODV
#routing 3 = simple flooding
#overlap 0 = NO overlap
#overlap 1 = AODV and CTP
#overlap 2 = CTP and Simple flooding
#overlap 3 = AODV and Simple flooding
#overlap 4 = All 3 protocols
for i in range(numNodes):
  msg = RoutMsg()
  rout = 0
  overlap = 0
  if (i < 10):
  	rout = 1  #nodes 0-9 will be CTP nodes
  elif (i < 20):
  	rout = 2  #nodes 10-19 will be AODV nodes
  elif (i < 30):
	rout = 3  #nodes 20-29 will be Simple flooding nodes
	
  msg.set_routing(rout)

  curNode = graph[i]
  connectedNodes = list(curNode.nextNodes)
  for j in range(len(connectedNodes)):
    connRout = 0
    if(connectedNodes[j] < 10):
      connRout = 1
    elif(connectedNodes[j] < 20):
      connRout = 2
    elif(connectedNodes[j] < 30):
      connRout = 3
    
    if(not(overlap == 0)): #already overlapping w/ 1
      if((rout == 1 and connRout == 2) or (rout == 2 and connRout  == 1)):
        if(not(overlap == 1)):
          overlap = 4 #all 3 overlaps present
      if((rout == 1 and connRout == 3) or (rout == 3 and connRout  == 1)):
        if(not(overlap == 2)):
          overlap = 4 #all 3 overlaps present
      if((rout == 2 and connRout == 3) or (rout == 3 and connRout  == 2)):
        if(not(overlap == 3)):
          overlap = 4 #all 3 overlaps present
  
    else: #no overlap already present
      if((rout == 1 and connRout == 2) or (rout == 2 and connRout  == 1)):
        overlap = 1
      if((rout == 1 and connRout == 3) or (rout == 3 and connRout  == 1)):
        overlap = 2
      if((rout == 2 and connRout == 3) or (rout == 3 and connRout  == 2)):
        overlap = 3

  msg.set_overlap(overlap)
  msg.set_numNodes(numNodes)
  pkt = t.newPacket()
  pkt.setType(msg.get_amType())
  pkt.setData(msg.data)
  pkt.setDestination(i)
  if(i in CDSgraphIDnums):
  	pkt.deliver(i, numNodes * 1000 + 1000 + i + 2)

 

while True:
  t.runNextEvent()
  if t.time() > endTime * 10000000000:
    break

print "Completed simulation."
