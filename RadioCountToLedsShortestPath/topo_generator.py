import random
import sys

finished = True
sel = "tree"
numNodes = 12
topoTxt = open("topo.txt", "w")


if(finished):
    sel = str(sys.argv[1])
    numNodes = int(sys.argv[2])

if sel.lower() == "star":
    for i in range(1, numNodes):
        topoTxt.write("0  " + str(i) + " " + str(random.randrange(-60, -49)) + "\n")
        topoTxt.write(str(i) + "  0" + " " + str(random.randrange(-60, -49)) + "\n")

if sel.lower() == "mesh":
    for i in range(0, numNodes):
        for j in range(0, numNodes):
            if(j != i):
                topoTxt.write(str(i) + "  " + str(j) + " " + str(random.randrange(-60, -49)) + "\n")

if sel.lower() == 'circle':
    for i in range(0, numNodes):
        if(i != numNodes - 1):
            topoTxt.write(str(i) + "  " + str(i + 1) + " " + str(random.randrange(-60, -49)) + "\n")
        else:
            topoTxt.write(str(i) + "  0 " + str(random.randrange(-60, -49)) + "\n")

if sel.lower() == 'tree':
    n = 3
    if(finished): n = int(sys.argv[3])
    curLeaf = 1
    i = 0
    cont = True
    while cont:
        for j in range (0, n):
            topoTxt.write(str(i) + "  " + str(curLeaf) + " " + str(random.randrange(-60, -49)) + "\n")
	    topoTxt.write(str(curLeaf) + "  " + str(i) + " " + str(random.randrange(-60, -49)) + "\n")
            curLeaf += 1
            if curLeaf == numNodes:
                cont = False
                break
        i += 1



topoTxt.close()
