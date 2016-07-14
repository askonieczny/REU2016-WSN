import mcds
class Node(object):
  def __init__(self,idNum):
    self.nextNodes = []
    self.idNum=idNum

def main():
    region = []
    for x in range(0, 6):
        region.append(Node(x))
    region[0].nextNodes = [1, 2]
    region[1].nextNodes = [0, 2]
    region[2].nextNodes = [0, 1, 4]
    region[3].nextNodes = [5]
    region[4].nextNodes = [2]
    region[5].nextNodes = [3]
    print mcds.findmcds(region)


if __name__ == '__main__':
    main()