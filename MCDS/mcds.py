# Calculate the MCDS given the graph
# Error bound = ln(n) + 1 where n = optimal set

#class Node(object):
#  def __init__(self,idNum,xCord,yCord):
#    self.nextNodes = []
#    self.idNum=idNum


def findmcds(region):
    adj_dict = {}  # dictionary which will hold sets of all nodes adjacent to key
    working_mcds = set()  # set which contains current MCDS
    previous_mcds = set() # to make sure elements are being added to mcds
    reachable = set()  # set which contains all reachable nodes
    max_card = 0  # highest cardinality
    next_node = ' '
    region_set = set()
    mcds = []
    index = -1

    for mote in region:       # This part of the code converts the given list of nodes into a dictionary with a key
        region_set.add(mote)  # equal to idNum and the value equal to a set of all elements in nextNodes
    for mote in region_set:
        if len(mote.nextNodes) > 0:
            adj_dict[mote.idNum] = set()
            adj_dict[mote.idNum].add(mote.idNum)
            for x in mote.nextNodes:
                adj_dict[mote.idNum].add(x)

    for node in adj_dict:  # find node with highest cardinality
        if not len(adj_dict[node]) < max_card:
            next_node = node
            max_card = len(adj_dict[node])
#    print 'next node to add to MCDS: %s with cardinality %d \n' % (next_node, max_card)
    working_mcds.add(next_node)  # add that node to mcds
#    print 'current mcds: ', working_mcds, '\n'
    reachable = reachable | adj_dict[next_node]  # add adjacent nodes to reachable
#    print 'reachable nodes ', reachable, '\n'
    for node in adj_dict:  # Remove redundant adjacency  
        adj_dict[node] = adj_dict[node] - reachable
    max_card = 0
    while len(adj_dict) - len(reachable) != 0 and previous_mcds != working_mcds:  # While there are still unreached
        previous_mcds = previous_mcds | working_mcds                              # nodes and no unconnected subgraphs
        for node in reachable:                  # repeat only using the cardinality of reachable nodes
            if not len(adj_dict[node]) < max_card:
                next_node = node
                max_card = len(adj_dict[node])
#        print 'next node to add to MCDS: %s with cardinality %d \n' % (next_node, max_card)
        working_mcds.add(next_node)
#        print 'current mcds: ', working_mcds, '\n'
        reachable = reachable | adj_dict[next_node]
#        print 'reachable nodes ', reachable, '\n'
        for node in adj_dict:
            adj_dict[node] = adj_dict[node] - reachable
        max_card = 0
    if len(adj_dict) - len(reachable) != 0: # if there is an unconnected subgraph, error
        print "Error! No valid MCDS for this region"
        return []
    for node in working_mcds:
        for i in range(len(region)):
            if region[i].idNum == node:
                index = i
                break
        mcds.append(region[index])
    return mcds
