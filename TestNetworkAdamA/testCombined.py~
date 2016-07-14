from TOSSIM import *
from tinyos.tossim.TossimApp import *
import random
from RoutMsg import *
import sys

#n = NescApp("TestNetwork", "app.xml")
#t = Tossim(n.variables.variables())
t = Tossim([])
r = t.radio()
numNodes = 20
endTime = 6 #seconds
sys.stdout = open('out_testCombined.txt','w')

f = open("combined_topo.txt", "r")
lines = f.readlines()
for line in lines:
  s = line.split()
  if (len(s) > 0):
	r.add(int(s[0]), int(s[1]), float(s[2]))

noise = open("noise.txt", "r")
lines = noise.readlines()
for line in lines:
  str = line.strip()
  if (str != ""):
    val = int(str)
    for i in range(0, numNodes):
      m = t.getNode(i);
      m.addNoiseTraceReading(val)



for i in range(0, numNodes):
  m = t.getNode(i);
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
t.addChannel("TestNetworkC", sys.stdout)
t.addChannel("APPS", sys.stdout)
t.addChannel("Traffic", sys.stdout)
t.addChannel("AODV_DBG", sys.stdout)
#t.addChannel("Acks", sys.stdout)

#Declares routing protocol for each node
#1 = CTP
#2 = AODV
for i in range(numNodes):
  msg = RoutMsg()
  if (i < 10):
  	msg.set_routing(1) #nodes 0-9 will be CTP nodes
  else:
  	msg.set_routing(2) #nodes 10-19 will be AODV nodes
  pkt = t.newPacket()
  pkt.setType(msg.get_amType())
  pkt.setData(msg.data)
  pkt.setDestination(i)
  pkt.deliver(i, numNodes * 1000 + 1000 + i + 2)

# while (t.time() < 150 * t.ticksPerSecond()):
#   t.runNextEvent()

while True:
  t.runNextEvent()
  if t.time() > endTime * 10000000000:
    break

print "Completed simulation."
