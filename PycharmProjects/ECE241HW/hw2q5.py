class BinaryTree:
    def __init__(self, value): ##initializing the tree
        self.value = value
        self.right = None
        self.left = None
    def get_left(self): ##retrieving value of the node to the left
        return self.left
    def get_right(self): ##retrieving value of the node to the right
        return self.right
    def get_value(self): ##returning value of current node
        return self.value
    def set_left(self,root): ## set functions to aide in assigning the valuse of the binary tree
        self.left=root
    def set_right(self,root):
        self.right=root

    def findRightMost(root):
        while root.get_right() != None: ##as long as there is a value to the right of current node, this function will repeat
            root = root.get_right()
        return root.get_value() ##when the current node is the rightmost it will return its value

    def findLeftMost(root):
        while root.get_left() != None: ##same structure as findRightMost but on the opposite side
            root = root.get_left()
        return root.get_value()

if __name__ == "__main__":
    root=BinaryTree(5) ## assigning values and creating the structure of the binary tree
    b=BinaryTree(10)
    c=BinaryTree(6)
    d=BinaryTree(8)
    e=BinaryTree(4)
    f=BinaryTree(2)
    g=BinaryTree(7)
    h=BinaryTree(9)
    i=BinaryTree(3)
    j=BinaryTree(1)
    root.set_left(b)
    root.set_right(h)
    b.set_left(c)
    b.set_right(d)
    c.set_left(e)
    c.set_right(f)
    d.set_left(g)
    h.set_left(i)
    h.set_right(j)

print("Left Most Node : ",end="")
print(BinaryTree.findLeftMost(root))
print("Right Most Node : ",end="")
print(BinaryTree.findRightMost(root))




