import sys
from pythonds.graphs import PriorityQueue, Graph, Vertex


def buildMST(self):
    self.MST = Graph()
    start = self.network.getVertex(list(self.negative_network.getVertices())[0])
    pq = PriorityQueue()
    for v in self.negative_network:
        v.setDistance(sys.maxsize)
        v.setPred(None)
    start.setDistance(0)
    start.setPred(start)
    pq.buildHeap([(v.getDistance(), v) for v in self.negative_network])
    while not pq.isEmpty():
        currentVert = pq.delMin()
        self.MST.addVertex(currentVert.id)
        print("CURRENT VERT " + currentVert.id)
        self.MST.vertList[currentVert.id] = currentVert
        if not currentVert.pred:
             pass
        else:
             self.M
             self.MST.addEdge(currentVert.id,currentVert.pred.id,-currentVert.getDistance())
             self.MST.addEdge(currentVert.pred.id,currentVert.id,-currentVert.getDistance())
        for nextVert in currentVert.getConnections():
            newCost = currentVert.getWeight(nextVert)
            if nextVert in pq and newCost < nextVert.getDistance():
                print("SETTING AS PARENT TO " + nextVert.id + " AT COST " + str(-newCost))
                nextVert.setPred(currentVert)
                nextVert.setDistance(newCost)
                pq.decreaseKey(nextVert, newCost)
    for v in self.MST.vertList:
        if self.MST.getVertex(v).pred:
            vert = self.MST.getVertex(v)
            d = {}
            d[vert.pred] = vert.getDistance() * -1
            vert.connectedTo = d
            self.MST.vertList[v] = vert
        else:
            vert = self.MST.getVertex(v)
            d = {}
            # d[vert.pred] = vert.getDistance() * -1
            vert.connectedTo = d
            self.MST.vertList[v] = vert


if __name__ == '__main__':
    osn = OSN()
    osn.buildGraph('facebook_network.csv')
    osn.buildMST()
    # print(osn.findDistance("a","Lynch"))
    # print(osn.findPath("a","Lynch"))
    m = osn.MST
    c = 0
    verts = 0
    for g in m.vertList:
        verts += 1
        print(g + " -> ")
        l = [(i.id, v) for i, v in m.getVertex(g).connectedTo.items()]
        if len(l) != 0:
            c += l[0][1]
        print(l)
    print(c)
    print(verts)
