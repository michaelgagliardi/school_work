#include "deck.h"

int main(int args, char* argv[]) {
    printf("Shuffling deck....\n");
    shuffle();
    deal_player_cards(&user);
    deal_player_cards(&computer);
    for(int x = 0; x<7; x++) {
        user.book[0] = '2';
        printf("\nPlayers 1's Hand - ");
        printHand(user);
        printf("Player 1's Book- ");
        printBook(user);
        printf("\nPlayers 2's Hand - ");
        printHand(computer);
        char rank;
        int input = 1;
        printf("Player 1's turn, enter a Rank: ");
        scanf("%c", &rank);
        while (input == 1) {
            if ((search(&user, rank)) == 1) {
                int numcards;
                numcards = transfer_cards(&computer, &user, rank);
                if (numcards == 0) {
                    printf("Player 2 had no %c's\n", rank);
                    struct card c = deck_instance.list[deck_size()];
                    printf("Go Fish, Player 1 draws a %c%c\n", c.rank, c.suit);
                    add_card(&user, &c);
                } else {
                    printf("Player 2 had %d %c's\n", numcards, rank);
                }
                input = 0;
                break;
            }
            else {
                printf("ERROR");
                printf("\nError - must have at least one card from rank to play");
                printf("\nPlayer 1's turn, enter a Rank: ");
                scanf("%c", &rank);
            }
        }
        //check_add_book(&user);
        printf("Players 1's Hand - ");
        printHand(user);
        printf("Players 2's Hand - ");
        printHand(computer);
    }
}