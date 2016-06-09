from TOSSIM import *
from array import *
from RadioCountMsg import *
import sys
import random
import Queue

baseStation = 0

class Node(object):
	def __init__(self,idNum):
		self.nextNodes = []
		self.pathLength = float('inf')
		self.idNum=idNum

def send(source, pkt): #final destination will always be the base station 
  	dest = allPaths[source]
  	pkt.setDestination(dest)
	pkt.deliver(dest, t.time() + 80)
	print "Sending from " + str(source) + " to " + str(dest)
	
	if dest != baseStation:
		send(dest, pkt)

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
allPaths = [-1 for x in range(numNodes)] 

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

graph[baseStation].pathLength = 0 #path length to same node is 0
que = Queue.Queue()
que.put(graph[baseStation])

while que.qsize() > 0:
	n = que.get()
	curLength = n.pathLength
	connectedNodes = list(n.nextNodes) #gets all connected node indexes
	while len(connectedNodes) != 0:
		curConnNode = graph[connectedNodes.pop()]
		if curConnNode.pathLength == float('inf'):
			curConnNode.pathLength = curLength + 1
			allPaths[curConnNode.idNum] = n.idNum #tells last connected node
			que.put(curConnNode)

t.addChannel('RadioCountToLedsC',sys.stdout)
for i in range(numNodes):
	t.getNode(i).bootAtTime(10)



for j in range(100):
	radioobjs = list()
	for i in range(numNodes):
		radioobjs.append(RadioCountMsg())
		radioobjs[i].set_temp(random.random() *19 + 64)
		radioobjs[i].set_hum(random.random() * 28 + 55)
		radioobjs[i].set_wind(random.random() * 20)
		pkt = t.newPacket()
		pkt.setType(radioobjs[i].get_amType())
		pkt.setData(radioobjs[i].data)
		send(i, pkt) #destination is always base station

for i in range(10000):
	t.runNextEvent()