#include "deck.h"
#include <stdio.h>


int shuffle(){
//deck_instance;
    deck_instance = *(struct deck*)malloc(sizeof(struct deck));
    const char suits[4] = {'H','D','S','C'};
    const char ranks[13] = {'2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'};
    int count = 0;
    srand((unsigned int)time(NULL));
    for(int r = 0; r < 13; r++){
        for(int s = 0; s < 4; s++){
            deck_instance.list[count].rank = ranks[r];
            deck_instance.list[count].suit = suits[s];
            count++;
        };
    }
    for(int i = 0; i<52; i++){
        int c1 = rand() % 52;
        int c2 = rand() % 52;
        struct card temp = deck_instance.list[c1];
        deck_instance.list[c1] = deck_instance.list[c2];
        deck_instance.list[c2] = temp;
    }
    return 0;
}

int deal_player_cards(struct player* target){
    for(int i = 0; i<7; i++){
        struct card new;
        struct hand* start;
        start = (struct hand*)malloc(sizeof(struct hand));
        if (start == NULL){return -1; }
        new = *(&deck_instance.list[deck_instance.top_card++]);
        start->top=new;
        start->next=target->card_list;
        target->card_list=start;
    }

}

int printHand(struct player user) {
    struct hand *temp_hand;

    temp_hand = user.card_list;
    while (temp_hand != NULL)
    {
        printf("%c%c ", temp_hand->top.rank, temp_hand->top.suit);
        temp_hand = temp_hand->next;
    }
    printf("\n");
}

int printBook(struct player user) {
        for (int u = 0; u < 7; u++) {
            if (user.book[u] != *("")) {
                printf("%c ", user.book[u]);
            }
        }
}

size_t deck_size()
{
    return 52 - deck_instance.top_card;
}