from TOSSIM import *
from array import *
from RadioCountMsg import *
import sys
import random

t = Tossim([])
r= t.radio()
sys.stdout = open('out_test.txt','w')


f = open("topo.txt", "r")
for line in f:
  s = line.split()
  if s:
    r.add(int(s[0]), int(s[1]), float(s[2]))



noise = open("meyer-heavy.txt", "r")
for line in noise:
  str1 = line.strip()
  if str1:
    val = -100
    for i in range(0, 2):
      t.getNode(i).addNoiseTraceReading(val)

for i in range(0, 2):
  t.getNode(i).createNoiseModel()


t.addChannel('RadioCountToLedsC',sys.stdout)
m1 = t.getNode(0)
m2 = t.getNode(1)
m3 = t.getNode(2)


m1.bootAtTime(10)
m2.bootAtTime(10)
m3.bootAtTime(10)



radioobjs = list()
for i in range(1000):
    radioobjs.append(RadioCountMsg())
    radioobjs[i].set_temp(random.random() *19 + 64)
    radioobjs[i].set_hum(random.random() * 28 + 55)
    radioobjs[i].set_wind(random.random() * 20)
    pkt = t.newPacket()
    pkt.setType(radioobjs[i].get_amType())
    pkt.setData(radioobjs[i].data)
    pkt.setSource(random.randint(1, 2))
    pkt.setDestination(0)
    pkt.deliver(0, t.time() + 10)
for i in range(10000):
    t.runNextEvent()
