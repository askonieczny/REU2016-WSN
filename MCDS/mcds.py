# Calculate the MCDS given the graph
from sets import Set

adjDict = {} # dictionary which will hold sets of all nodes adjacent to key
f = open('topo.txt', 'r')
lines = f.readlines()
for line in lines: # Gather information from topo.txt
    edge = line.split()
    if len(edge) > 0:
        if edge[0] in adjDict:
            adjDict[edge[0]].add(edge[1])
        else:
            adjDict[edge[0]] = set()
            adjDict[edge[0]].add(edge[0])
            adjDict[edge[0]].add(edge[1])
print adjDict
