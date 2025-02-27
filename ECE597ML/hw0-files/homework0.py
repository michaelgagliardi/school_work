# Homework 0 for ECE 570

# Create two ways of adding 2 100x100 numpy arrays: one using 2 for loops and one using the '+' operator. Time their exectution 1000 times each and plot results in histogram.

##importing necessary modules
import numpy
import random
import time
import matplotlib.pyplot as plt

##asking user input for size of arrays to add
rows = int(input("Enter horizontal size of matrices: \n"))
columns = int(input("Enter vertical size of matrices: \n"))
trials = int(input("Enter number of time trials you would like to perform: \n"))

##initializing arrays with proper shape, all values are initially set to zero
array1 = numpy.zeros(shape=(rows, columns))
array2 = numpy.zeros(shape=(rows, columns))
array3 = numpy.zeros(shape=(rows, columns))

##initialzing empty vectors to hold the execution times
looptime = numpy.array([])
operationtime = numpy.array([])

##filling arrays 1 and 2 with random integers
for j in range(len(array1)):
    for i in range(len(array1)):
        array1[i, j] = random.randint(0, 100)
        array2[i, j] = random.randint(0, 100)
        i = i + 1
    j = j + 1

##function to add two arrays using 2 'for' loops, loops through each row and column, adding one by one
def LoopAdd(array1, array2):
    for j in range(len(array1)):
        for i in range(len(array1)):
            array3[i, j] = array1[i, j] + array2[i, j]
            i = i + 1
        j = j + 1
    return array3


##function to add two arrays using the operator symbol
def OpAdd(array1, array2):
    array3 = array1 + array2
    return array3


##timing the execution time for the set number trials inputted by the user
for i in range(trials):
    start_time = time.time()
    LoopedArray = LoopAdd(array1, array2)
    end_time = time.time()
    total_time = end_time - start_time
    looptime = numpy.append(looptime, total_time)

    start_time = time.time()
    OperationArray = OpAdd(array1, array2)
    end_time = time.time()
    total_time = end_time - start_time
    operationtime = numpy.append(operationtime, total_time)


##creating subplots

fig, axs = plt.subplots(1, 2, sharey=True, tight_layout=True)

##plotting two histograms for each of the methods of adding arrays and giving them appropriate titles
axs[0].hist(looptime)
axs[1].hist(operationtime)
axs[0].set_title("Execution Time Using For Loops")
axs[1].set_title('Execution Time Using "+" Operator')
fig.show()
