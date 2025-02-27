class City: ##creating the city class with proper attributes
    def __init__(self, cid: str = None, cname: str = None, cstate: str = None, pop: str = None, cities=None):
        self.cid = cid
        self.cname = cname
        self.cstate = cstate
        self.pop = pop
        self.cities = cities
    def __str__(self): ##creating the string output to display all necessary information
        return "City_ID: %s; City_Name: %s; City_State: %s; City_Population: %s; Cases: %s" % (self.cid, self.cname, self.cstate, self.pop, self.cities)

class COV19Library: ##creating the COVID19_Library class
    def __init__(self, sorted = False):
        self.sorted = sorted
        global database ##creating a global variable assigned to a list to hold all city information
        database = []
        self.database = database
    def __str__(self): ##converting to string for a readable output
        y = [str(x) for x in database]
        y = str(y)
        return y

    def LoadData(self, filename: str): ##LoadData method to load the information
        self.filename=filename
        if filename == "cov19_city": ##make sure the correct file is supposed to be opened
           f1 = open('/Users/michaelgagliardi/Documents/Sophomore Year/ECE 241/cov19_city.csv', 'r') ##using the filepath to open and read the data
           lines = f1.readlines() ##reading all lines of the data
           i = 1
           while 1 <= i <= 942: ##selecting only the data, not the headers
                row = lines[i] ##assigning row to each line
                city = row.split(',') ##splitting the cities based on the comma delimiter
                city[2] = city[1].split(" ") ##splitting the city and state into two seperate objects in list
                if len(city[2]) > 1: ## most city/states are split by a space, this conditional assigns a variable to the city name and state name
                    city[1] = city[2][:-1]
                    city[2] = city[2][-1]
                    cname = ' '
                    cname = cname.join(city[1])
                    city[0] = str(city[0])
                else: ##there was a singular instance where the city name was too long to have a state, this just assigns the city name
                    cname = str(city[2])
                x = City(city[0], cname, city[2], city[3], city[63]) ##creating all the cities
                database.append(x) ##inputting the cities into a list
                i = i+1
        else:
            print("file not found") ##if the wrong filename is inputted this is the output

    def linearSearch(self,city: str, attribute: str): ##linear seach method
        if attribute == "id": ##if searched by id
            city=str(city)
            if any(x for x in database if str(x.cid) == city): ##finding city id in the database that matches the inputted id
                for x in database:
                    if x.cid == city: ##if its match, return the city and all its information
                        return x
            else:
                return "City not found"
        elif attribute == "city": ##searching by city name
            city = str(city)
            if any(x for x in database if x.cname == city): ##same structure as searching by id, just different attribute
                for x in database:
                    if x.cname == city:
                        return x
            else:
                return "City not found"

    def quickSort(self): ##creating the quickSort using recursive methods
        x=COV19Library
        x.quickSortHelper(x, database, 0, len(database) - 1)
        y = [str(i) for i in database]
        y = str(y) ##creating a readable output
        self.sorted = True ##changing the sorted aspect of the COVID19_Library to true
        return y
    def quickSortHelper(self, alist, first, last): ##
        if first < last:
            x = COV19Library
            splitpoint = x.partition(x, alist, first, last) ##merging the sorted lists all together
            x.quickSortHelper(x, alist, first, splitpoint - 1)
            x.quickSortHelper(x, alist, splitpoint + 1, last)
    def partition(self, alist, first, last):
        pivotvalue = alist[first].cname ##selecting the city name attribute, assigning the pivotvalue
        leftmark = first + 1
        rightmark = last
        done = False
        while not done:
            while leftmark <= rightmark and alist[leftmark].cname <= pivotvalue:
                leftmark = leftmark + 1
            while alist[rightmark].cname >= pivotvalue and rightmark >= leftmark:
                rightmark = rightmark - 1
            if rightmark < leftmark:
                done = True
            else:
                temp = alist[leftmark]
                alist[leftmark] = alist[rightmark]
                alist[rightmark] = temp

            temp = alist[first]
            alist[first] = alist[rightmark]
            alist[rightmark] = temp

            return rightmark
    def buildBST(self): ##buidling the BST using classes and methods below
        cid=sorted(database, key=lambda x: x.cid, reverse=False) ##using a sorted array by cid to create a balanced BST
        mytree = BinarySearchTree()
        for i in range(0, len(cid) - 1):
            mytree[i] = cid[i]
        return mytree ##creating a desired return
    def searchBST(self,cid:str):
        x = COV19Library
        y = x.buildBST(x) ##building the BST so it can be searched
        for i in range(0,len(y)-1):
            if cid == str(y[i].cid): ##searching the BST by City ID
                return y[i]
        return "City Not Found"



class TreeNode: ##creating the TreeNodes, based off the BST code provided in class
    def __init__(self,key,val,left=None,right=None,parent=None):
        self.key = key
        self.payload = val
        self.leftChild = left
        self.rightChild = right
        self.parent = parent
        self.balanceFactor = 0
##Code below helps assign the left and right child, defines roots and leaves
    def hasLeftChild(self):  #
        return self.leftChild

    def hasRightChild(self):
        return self.rightChild

    def isLeftChild(self):
        return self.parent and self.parent.leftChild == self

    def isRightChild(self):
        return self.parent and self.parent.rightChild == self

    def isRoot(self):
        return not self.parent

    def isLeaf(self):
        return not (self.rightChild or self.leftChild)

class BinarySearchTree: ##creating the BST

    def __init__(self): ##initializing
        self.root = None
        self.size = 0

    def length(self): ##returns the size of the tree
        return self.size

    def __len__(self): ##allows for use of len function
        return self.size

    def put(self,key,val): ##assigns the value and key of the node in
        if self.root:
            self._put(key,val,self.root)
        else:
            self.root = TreeNode(key,val) ##creates new node if not it is not the root
        self.size = self.size + 1

    def _put(self,key,val,currentNode): ##recursive put that assigns the values to their proper place
        if key < currentNode.key: ##insures the order of the tree is proper, seeing if the key is less than current node to assign left
            if currentNode.hasLeftChild(): ##if node already has a child
                   self._put(key,val,currentNode.leftChild) ##the left child is put in its proper place
            else:
                   currentNode.leftChild = TreeNode(key,val,parent=currentNode) ##if it doesnt have left child, the left child is created
        else:
            if currentNode.hasRightChild(): ##the same structure as above but for the right child i.e. greater than
                   self._put(key,val,currentNode.rightChild)
            else:
                   currentNode.rightChild = TreeNode(key,val,parent=currentNode)

    def __setitem__(self,k,v): ##sets the key and valye
       self.put(k,v)

    def get(self,key): ##functions below are used to retrieve the necessary values from the BST
       if self.root:
           res = self._get(key,self.root)
           if res:
                  return res.payload
           else:
                  return None
       else:
           return None

    def _get(self,key,currentNode):
       if not currentNode:
           return None
       elif currentNode.key == key:
           return currentNode
       elif key < currentNode.key:
           return self._get(key,currentNode.leftChild)
       else:
           return self._get(key,currentNode.rightChild)

    def __getitem__(self,key):
       return self.get(key)




a = COV19Library()
a.LoadData("cov19_city")
print(a.searchBST('49180'))

