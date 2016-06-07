#Import tossim, array and sys files.

from TOSSIM import *

from array import *

import sys

#create an object of tossim module

t = Tossim([]);

#add debug channels

sys.stdout=open('/opt/tinyos-2.1.2/apps/Blink/BlinkC', 'w');

t.addChannel("BlinkC", sys.stdout);

#start execution of mote

t.getNode(10).bootAtTime(0);

#Execute an event
for i in range(0, 1000):
	t.runNextEvent();

f = open("topo.txt", "r")
for line in f:
	s = line.split()
	if s:
		t.add(int(s[0]), int(s[1]), float(s[2]))

noise = open("meyer-heavy.txt", "r")
for line in noise:
	str1 = line.strip()
	if str1:
		val = -100
		for i in range(0, 2):
	    		t.getNode(i).addNoiseTraceReading(val);
