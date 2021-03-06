from TOSSIM import *
from array import *
from RadioCountMsg import *
import sys
import random
import Queue

class Node(object):
	def __init__(self,idNum):
		self.nextNodes = []
		self.pathLength = float('inf')
		self.idNum=idNum

def send(source, dest, pkt):
  	pkt.setType(radioobjs[source].get_amType())
  	pkt.setData(radioobjs[source].data)
  	path = []
	send_r(source, dest, pkt, path)

def send_r(source, dest, pkt, path):
	path.append(dest)
	if allPaths[source][dest] == source:
		while len(path) > 0:
			tempDest = path.pop()
			pkt.setDestination(tempDest)
			pkt.deliver(tempDest, t.time() + 80)
			print "Sending from " + str(source) + " to " + str(tempDest)
			source = tempDest
	else:
		send_r(source, allPaths[source][dest], pkt, path)

t = Tossim([])
r= t.radio()

listNodes = []
sys.stdout = open('out_test.txt','w')


f = open("topo.txt", "r")
for line in f:
	s = line.split()
	if s:
		valOne = int(s[0])
		valTwo = int(s[1])
		r.add(int(s[0]), int(s[1]), float(s[2]))
		if valOne not in listNodes:
			listNodes.append(int(s[0]))
		if valTwo not in listNodes:
			listNodes.append(int(s[1]))

numNodes = len(listNodes) #MUST CHANGE IF YOU CHANGE # OF NODES IN TOPO FILE
listNodes = []
graph = []
for i in range(numNodes):
	graph.append(Node(-1))
allPaths = [[-1 for x in range(numNodes)] for y in range(numNodes)] 

f = open("topo.txt", "r")
for line in f:
	s = line.split()
	if s:
		valOne = int(s[0])
		valTwo = int(s[1])
		if valOne not in listNodes:
			graph[valOne] = Node(valOne)
			listNodes.append(int(s[0]))
		if valTwo not in listNodes:
			graph[valTwo] = Node(valTwo)
			listNodes.append(int(s[1]))

		graph[valOne].nextNodes.append(valTwo) #add connection from s[0] to s[1] in graph


noise = open("meyer-heavy.txt", "r")
for line in noise:
	str1 = line.strip()
	if str1:
		val = -100
		for i in range(0, numNodes):
			t.getNode(i).addNoiseTraceReading(val)

for i in range(0, numNodes):
	t.getNode(i).createNoiseModel()

for selNode in range(numNodes):
	que = Queue.Queue()
	que.put(graph[selNode])
	for j in range(numNodes):
		graph[j].pathLength = float('inf') #reset all path lengths

	graph[selNode].pathLength = 0 #path length to same node is 0

	while que.qsize() > 0:
		n = que.get()
		curLength = n.pathLength
		connectedNodes = list(n.nextNodes) #gets all connected node indexes
		while len(connectedNodes) != 0:
			curConnNode = graph[connectedNodes.pop()]
			if curConnNode.pathLength == float('inf'):
				curConnNode.pathLength = curLength + 1
				allPaths[selNode][curConnNode.idNum] = n.idNum #tells last connected node
				que.put(curConnNode)

t.addChannel('RadioCountToLedsC',sys.stdout)
for i in range(numNodes):
	t.getNode(i).bootAtTime(10)


radioobjs = list()
for i in range(numNodes):
	radioobjs.append(RadioCountMsg())
	if(i == 5): #this should change according to what you want to send and from which nodes
		radioobjs[i].set_temp(70)
		radioobjs[i].set_hum(50)
		radioobjs[i].set_wind(80)
    	# radioobjs[i].set_temp(random.randint(64, 83))
    	# radioobjs[i].set_hum(random.randint(55, 83))
    	# radioobjs[i].set_wind(random.randint(0, 20))




pkt = t.newPacket()
send(5, 3, pkt)
for i in range(1000):
	t.runNextEvent()
