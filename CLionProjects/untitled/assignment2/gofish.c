#include "deck.h"

int main(int args, char* argv[]) {
    printf("Shuffling deck....\n");
    shuffle();
    deal_player_cards(&user);
    deal_player_cards(&computer);
    int numCards;
    numCards = deck_instance.numCards;
    //check_add_book(&user);
   // check_add_book(&computer);
    while (user.book[7] == NULL && computer.book[7] == NULL || user.card_list != NULL) {
        printf("Players 1's Hand - ");
        printHand(user);
        printf("Player 1's Book- ");
        printBook(user);
        printf("Players 2's Book - ");
        printBook(computer);
        user_play(&user);
        printf("Players 1's Hand - ");
        printHand(user);
        printf("Player 1's Book- ");
        printBook(user);
        printf("Players 2's Book - ");
        printBook(computer);
        computer_play(&computer);
        printf("Players 1's Hand - ");
        printHand(user);
        printf("Player 1's Book- ");
        printBook(user);
        printf("Players 2's Book - ");
        printBook(computer);
    }
}