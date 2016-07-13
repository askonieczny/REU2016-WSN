# Calculate the MCDS given the graph
# Error bound = ln(n) + 1 where n = optimal set


def findmcds(region):
    adj_dict = {}  # dictionary which will hold sets of all nodes adjacent to key
    working_mcds = set()  # set which contains current MCDS
    reachable = set()  # set which contains all reachable nodes
    max_card = 0  # highest cardinality
    next_node = ' '

    f = open('topo.txt', 'r')
    lines = f.readlines()
    for line in lines:  # Gather information from topo.txt
        edge = line.split()
        if len(edge) > 0:
            if edge[0] in adj_dict and edge[1] in region:
                adj_dict[edge[0]].add(edge[1])
            elif edge[0] in region and edge[1] in region:
                adj_dict[edge[0]] = set()
                adj_dict[edge[0]].add(edge[0])
                adj_dict[edge[0]].add(edge[1])
    for node in adj_dict:  # find node with highest cardinality
        if not len(adj_dict[node]) < max_card:
            next_node = node
            max_card = len(adj_dict[node])
#    print 'next node to add to MCDS: %s with cardinality %d \n' % (next_node, max_card)
    working_mcds.add(next_node)
#    print 'current mcds: ', working_mcds, '\n'
    reachable = reachable | adj_dict[next_node]
#    print 'reachable nodes ', reachable, '\n'
    for node in adj_dict:
        adj_dict[node] = adj_dict[node] - reachable
    max_card = 0
    while len(adj_dict) - len(reachable) != 0:
        for node in reachable:  # find node with highest cardinality
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
    return working_mcds
