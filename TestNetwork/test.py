from TOSSIM import *
from tinyos.tossim.TossimApp import *
import random
from RoutMsg import *
import sys

#n = NescApp("TestNetwork", "app.xml")
#t = Tossim(n.variables.variables())
t = Tossim([])
r = t.radio()

numNodes = 10

f = open("sparse-grid.txt", "r")
lines = f.readlines()
for line in lines:
  s = line.split()
  if (len(s) > 0):
    if s[0] == "gain":
      r.add(int(s[1]), int(s[2]), float(s[3]))

noise = open("meyer-short.txt", "r")
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
  m.bootAtTime(10)
  print "Booting ", i, " at 10 "

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
#t.addChannel("App", sys.stdout)
t.addChannel("Traffic", sys.stdout)
#t.addChannel("Acks", sys.stdout)

#Declares routing protocol for each node
#1 = AODV
#2 = CTP
for i in range(numNodes):
  msg = RoutMsg()
  if (i % 2 == 0):
    msg.set_routing(1)
  else:
    msg.set_routing(2)
  pkt = t.newPacket()
  pkt.setType(msg.get_amType())
  pkt.setData(msg.data)
  pkt.setDestination(i)
  pkt.deliver(i, 11)

while (t.time() < 200 * t.ticksPerSecond()):
  t.runNextEvent()

print "Completed simulation."
