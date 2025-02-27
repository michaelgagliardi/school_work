from ECE371.Lab2.des import binvalue


def compute_s_box(self, block, round):
    ###################################your code goes here###################################
    # compute the corresponding row and column in the s box and choose the correct s box based on round
    # the input block is a list of integers for 1 or 0  e.g. block=[1,1,0,0,0,0,0]
    # return a string of 4 bits e.g. '1111' as the output, the binvalue() function is helpful
    c = block[1:5]
    r = block[0::5]
    col = ''
    row = ''
    for i in c:
        col += str(i)
    for i in r:
        row += str(i)
    x = int(row, 2)
    y = int(col, 2)
    out = S_BOX[round][x][y]
    print(binvalue(out, 4))
    print(out)
    return binvalue(out, 4)

def substitute(self, d_e):#Substitute bytes using SBOX
        subblocks = nsplit(d_e, 6)#Split bit array into sublist of 6 bits
        ###################################your code goes here###################################
        #for each 6 bit subblock you need to apply the corresponding s box (using the compute_s_box function) and save the result in result value
        # result is a list of integer values 1 or 0
        #the following code is wrong and needs to be replaced
        print(len(subblocks))
        result = list()
        for i in range(len(subblocks)):
            print(subblocks[i])
            result.append(int(x) for x in self.compute_s_box(subblocks[i],i))
        return result
