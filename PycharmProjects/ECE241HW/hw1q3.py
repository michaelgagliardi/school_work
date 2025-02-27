"""tictactoe game for 2 players"""
choices=[]
for x in range(0, 10):
    choices.append(x) ##adding the choices to the choices list

playerOneTurn = True
winner = False

def printBoard() : ##printing the playboard
    print( '\n -----')
    print( '|' + str(choices[1]) + '|' + str(choices[2]) + '|' + str(choices[3]) + '|')
    print( ' -----')
    print( '|' + str(choices[4]) + '|' + str(choices[5]) + '|' + str(choices[6]) + '|')
    print( ' -----')
    print( '|' + str(choices[7]) + '|' + str(choices[8]) + '|' + str(choices[9]) + '|')
    print( ' -----\n')


while winner == False :
    printBoard() ##creating a loop that continues the game as long as no one wins, reprinting the board before each turn

    if playerOneTurn :
        print( "Player 1:")
    else :
        print( "Player 2:")

    try:
        choice = int(input(">> "))
    except:
        print("please enter a valid field")
        continue

    if choices[choice - 1] == x or choices[choice] == 0 :
        print("illegal move, please try again")
        continue

    if playerOneTurn :
        choices[choice - 1] = x
    else :
        choices[choice - 1] = y

    playerOneTurn = not playerOneTurn

    for x in range (0, 3) : ##deciding the winner
       y = x * 3
       if (choices[y] == choices[(y + 1)] and choices[y] == choices[(y + 2)]) :
            winner = True
       if (choices[x] == choices[(x + 3)] and choices[x] == choices[(x + 6)]) :
            winner = True
            printBoard()

    if((choices[0] == choices[4] and choices[0] == choices[8]) or
       (choices[2] == choices[4] and choices[4] == choices[6])) :
        winner = True
        printBoard()

print ("Player " + str(int(playerOneTurn + 1)) + " wins!\n")    ##printing who won the game