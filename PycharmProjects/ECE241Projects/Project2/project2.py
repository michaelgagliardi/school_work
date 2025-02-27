import pythonds as ds
import sys
import csv



class Vertex(): ##creating the vertex class
    def __init__(self, key, n=1):
        self.id = key
        self.connectedTo = {}
        self.color = 'white'
        self.dist = sys.maxsize
        self.pathweight = 0
        self.pred = None
        self.disc = 0
        self.fin = 0
        self.number = n
        self.edgeList = []
        self.isAcceptingState = None

    def addNeighbor(self, nbr, weight=0):
        self.connectedTo[nbr] = weight

    def setColor(self, color):
        self.color = color

    def setDistance(self, d):
        self.dist = d

    def setPred(self, p):
        self.pred = p

    def setDiscovery(self, dtime):
        self.disc = dtime

    def setFinish(self, ftime):
        self.fin = ftime

    def getFinish(self):
        return self.fin

    def getDiscovery(self):
        return self.disc

    def getPred(self):
        return self.pred

    def getDistance(self):
        return self.dist

    def getColor(self):
        return self.color

    def getConnections(self):
        return self.connectedTo.keys()

    def getWeight(self, nbr):
        return self.connectedTo[nbr]

    def __str__(self):
        return str(self.id) + ' connected to: ' + str([x.id for x in self.connectedTo])

    def getId(self):
        return self.id

    def setAcceptingState(self):
        self.isAcceptingState = True

    def addEdge(self, e):
        self.edgeList.append(e)

    def followEdge(self, c):
        for i in self.edgeList:
            if i.character == c:
                return i.destination
        return None


class Graph(): ###creating graph class
    def __init__(self):
        self.vertList = {}
        self.numVertices = 0

    def addVertex(self, key):
        self.numVertices = self.numVertices + 1
        newVertex = Vertex(key)
        self.vertList[key] = newVertex

    def getVertex(self, n):
        if n in self.vertList:
            return self.vertList[n]
        else:
            return None

    def __contains__(self, n):
        return n in self.vertList

    def addEdge(self, f, t, cost=0):
        if f not in self.vertList:
            self.addVertex(f)
        if t not in self.vertList:
            self.addVertex(t)
        self.vertList[f].addNeighbor(self.vertList[t], cost)

    def getVertices(self):
        return self.vertList.keys()

    def __iter__(self):
        return iter(self.vertList.values())



class OSN(): ##OSN class
    def __init__(self):
        self.network = Graph() #storing the graph in self.network
        self.negative_network = Graph() ##storing a similar graph but this one will have negative weights
        self.MST = Graph() ##creating the maximum spanning tree

    def bfs(self, start): ## the bfs code similar to that provided in class
        start.setDistance(0)
        start.setPred(None)
        vertQueue = ds.Queue()
        vertQueue.enqueue(start)
        while (vertQueue.size() > 0):
            currentVert = vertQueue.dequeue()
            for nbr in currentVert.getConnections():
                if (nbr.getColor() == 'white'):
                    nbr.setColor('gray')
                    nbr.setDistance(currentVert.getDistance() + 1)
                    nbr.setPred(currentVert)
                    vertQueue.enqueue(nbr)
            currentVert.setColor('black')

    def buildGraph(self, filename=str): ##building the graph
            file = list(csv.reader(open(filename, 'r'))) ##opening the file, reading the lines
            for i in file: ##opening each line in file
                user1 = i[0] #first column is 'user 1'
                user2 = i[1] #second column is 'user 2'
                weight = int(i[2]) #third column is 'weight'
                self.network.addEdge(user1, user2, weight) #adding the vertexes to the graph
                self.network.addEdge(user2, user1, weight) #adding the vertexes in the opposite way to make a 2 way graph
                self.negative_network.addEdge(user1,user2,weight*-1) ##adding the vertexes with negative weights
                self.negative_network.addEdge(user2,user1,weight*-1) ##creating the two way negatice networks

    def reset(self): ##creating a reset function to reset the bfs and MST build
        for v in self.network:
            v.dist = sys.maxsize
            v.pred = None
            v.color = 'white'
        for v in self.MST:
            v.dist = sys.maxsize
            v.pred = None
            v.color = 'white'

    def buildMST(self): ##building the MST, this will be very similar to the prim function provided in class
        self.reset()
        self.MST = Graph() #initializing the graph
        start = self.network.getVertex(list(self.negative_network.getVertices())[0]) ##running a prim-like function on negative network
        pq = ds.PriorityQueue()
        for v in self.negative_network:
                v.setDistance(sys.maxsize)
                v.setPred(None)
        start.setDistance(0)
        pq.buildHeap([(v.getDistance(), v) for v in self.negative_network])
        while not pq.isEmpty():
            currentVert = pq.delMin()
            for nextVert in currentVert.getConnections():
                newCost = currentVert.getWeight(nextVert)
                if nextVert in pq and newCost < nextVert.getDistance():
                    nextVert.setPred(currentVert)
                    nextVert.setDistance(newCost)
                    pq.decreaseKey(nextVert, newCost)
                else:
                    self.MST.addEdge(currentVert.id, currentVert.pred.id, -currentVert.getDistance()) ##adding to the MST
                    self.MST.addEdge(currentVert.pred.id, currentVert.id, -currentVert.getDistance()) ##adding to the MST to make it 2 ways

    def findDistance(self, user1=str, user2=str): ##using bfs to find the distance between two
        self.reset() ##resetting
        x=self.network.getVertex(user1) #getting one vertex
        y=self.network.getVertex(user2) #getting the other vertec
        self.bfs(x) #running the first vertex through the bfs
        d=Vertex.getDistance(y) #getting the distance
        return int(d) #printing

    def findPath(self,user1=str, user2=str): ##uses the MST to find the distance between 2 users
        self.reset()
        x = self.MST.getVertex(user1) ##getting the vertexes through the MST
        y = self.MST.getVertex(user2)
        self.bfs(x) ##running it through the bfs
        path = [] #creating a path list
        path.append(y.getId()) #adding user 2 to the list
        v=y.getPred() ##grabbing the predecessor
        while x.getId() != v.getId(): ##while user 1 is not user 2
            path.append(v.getId()) ##appending the next user to the path list
            v=v.getPred() #moving down the path
        path.append(x.getId()) #appending the last user 2 id to list
        path.reverse() ##reversing the list
        names = " -> ".join(path) #adding the arrows to the list
        return names


    def bfs_path(self, start): ##attempting to alter the bfs method to pick up weight vs person
        start.setDistance(0)
        start.setPred(None)
        vertQueue = ds.Queue()
        vertQueue.enqueue(start)
        while (vertQueue.size() > 0):
            currentVert = vertQueue.dequeue()
            for nbr in currentVert.getConnections():
                if (nbr.getColor() == 'white'):
                    nbr.setColor('gray')
                    nbr.setDistance(currentVert.getDistance() + 1)
                    nbr.setPred(currentVert)
                    for x in nbr.getConnections():
                        if x.getDistance() == nbr.getDistance() - 1:
                            t_weight = x.pathweight + x.getWeight(nbr)
                            if x.pathweight < t_weight:
                                x.pathweight = t_weight
                                nbr.setPred(x)
                    vertQueue.enqueue(nbr)
            currentVert.setColor('black')

    def findClosePath(self, user1=str, user2=str): ##finding the closest path from one user to another
        self.reset()
        x = self.MST.getVertex(user1)
        y = self.MST.getVertex(user2)
        self.bfs_path(x)
        path = []
        path.append(y.getId())
        v = y.getPred()
        while x.getId() != v.getId():
            path.append(v.getId())
            v = v.getPred()
        path.append(v.getId())
        path.reverse()
        names = " -> ".join(path)
        return str(names),v.pathweight








