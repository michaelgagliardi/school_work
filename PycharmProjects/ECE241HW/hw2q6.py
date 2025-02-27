def listMerge(alist, left, middle, right, a, b, c, pos):  # function to merge the three sorted lists
    comparisons = 0  # start comparisons at zero
    while a < len(left) and b < len(middle) and c < len(right):  #insuring proper indexes and checking lengths
        if (left[a] > right[c]):  #Checking if element in left third is greater than that in right
            if (left[a] > middle[b]):  # If yes, then checking if its bigger than middle third
                alist[pos] = left[a] #if yes again, assign this element to pos position
                a += 1  #move to next index
            else:
                alist[pos] = middle[b] ##if element in left third is not bigger than element in middle third, assign middle third element to pos and incriment
                b += 1
            comparisons += 1 ##add comparison
        else:
            if (right[c] > middle[b]):  # if no to the first condition, than element in right is greater than element in left so see if it is larger than element in middle
                alist[pos] = right[c] #if yes, set that value to position pos
                c += 1 #incriment
            else:
                alist[pos] = middle[b] #if element in right is not bigger, then assign element in middle to pos
                b += 1 #incriment
            comparisons += 1 #add comparison
        comparisons += 1 #add comparison
        pos += 1 #move to next index

    while a < len(left) and b < len(middle):
        if left[a] > middle[b]:  # CONDITION 4
            alist[pos] = left[a]
            a += 1
        else:
            alist[pos] = middle[b]
            b += 1
        pos += 1
        comparisons += 1

    while a < len(left) and c < len(right):
        if left[a] > right[c]:  # CONDITION 5
            alist[pos] = left[a]
            a += 1
        else:
            alist[pos] = right[c]
            c += 1
        pos += 1
        comparisons += 1

    while b < len(middle) and c < len(right):
        if middle[b] > right[c]:
            alist[pos] = middle[b]
            b += 1
        else:
            alist[pos] = right[c]
            c += 1
        pos += 1
        comparisons += 1
    while a < len(left):
        alist[pos] = left[a]
        a += 1
        pos += 1
    while b < len(middle):
        alist[pos] = middle[b]
        b += 1
        pos += 1
    while c < len(right):
        alist[pos] = right[c]
        c += 1
        pos += 1

    return comparisons


def mergeSort_3_way(alist):
    global pos
    if len(alist) < 2:
        return 0

    leftmid = len(alist) // 3
    rightmid = (2 * len(alist)) // 3

    leftthird = alist[:leftmid]
    middlethird = alist[leftmid:rightmid]
    rightthird = alist[rightmid:]

    a = mergeSort_3_way(leftthird)
    b = mergeSort_3_way(middlethird)
    c = mergeSort_3_way(rightthird)

    d = listMerge(alist, leftthird, middlethird, rightthird, 0, 0, 0, pos)


    return a + b + c + d



pos = 0
x = [23,43,56,87,63,46,98,35,79,75,22,11,34,78,65]
y = mergeSort_3_way(x)
print("Sorted list :", x)
print("Comparisons :", y)