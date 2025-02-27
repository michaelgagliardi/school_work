#include "player.h"
#include <stdio.h>
#include <time.h>

int add_card(struct player *target, struct card *new_card) {
    struct hand *bottom = (struct hand *) malloc(sizeof(struct hand));
    struct hand *temp = target->card_list;
    bottom->top.rank = new_card->rank;
    bottom->top.suit = new_card->suit;
    bottom->next = NULL;

    if (target->card_list == NULL) {
        target->card_list = bottom;
        target->hand_size++;
        return 1;
    } else {
        while (temp->next != NULL) {
            temp = temp->next;
        }
    }
    temp->next = bottom;
    target->hand_size++;
    return 0;
}

int search(struct player* target, char rank) {
    struct hand *source = target->card_list;
    if (source == NULL) { return 0; }
    while (source != NULL) {
        if (source->top.rank == rank) {
            return 1;
        }
        source = source->next;
    }
        return 0;
    }

int remove_card(struct player* target, struct card* old_card){
    struct hand* i = target->card_list;
    struct hand* prev = NULL;
    if (i == NULL){
        return -1;
    }
    while (i->top.rank != old_card->rank || i->top.suit != old_card->suit){
        prev = i;
        i = i->next;
        if (i == NULL){
            return -1;
        }
    }
    if (prev != NULL){
        prev->next = i -> next;
    }
    else{
        target->card_list = i->next;
    }

    free(i);
    --target->hand_size;
    return 0;
}

char check_add_book(struct player* target) {
    struct hand *check_hand = target->card_list;
    if (check_hand == NULL) { return 0; }
    int books = 0;
    int card_count = 0;
    while (check_hand != NULL) {
        if (check_hand->top.rank == check_hand->next->top.rank) {
            card_count++;
            if (card_count == 4) {
                target->book[books] = check_hand->top.rank;
                books++;
                remove_card(target, &check_hand->top);
                return books;
            }

        }
        check_hand = check_hand ->next;
    }
}

int transfer_cards(struct player* src, struct player* dest, char rank){
    struct hand* source = src -> card_list;
    if (source == NULL) { return 0; }
    int numcards = 0;
    while (source != NULL){
        if (source->top.rank == rank) {
            numcards++;
            add_card(dest, &source->top);
            remove_card(src, &source->top);
        }
        source = source -> next;
    }
    return numcards;

}

int game_over(struct player* target){
    char score = '7';
    if (target->book == &(score)){
        return 1;
    }
    else {
        return 0;
    }
}

int reset_player(struct player* target){

}

char computer_play(struct player* target){
    srand(time(NULL));
    struct hand x,y;
    x = *(target)->card_list;
    y = *(target)->card_list->next;
    int guess = rand() % y.top.rank;//revise
    printf("Player 2's turn, enter a Rank:" ); //revise
   // if (search(user, guess) == 1) {
    //    remove_card(computer, guess);
    //    remove_card(user, guess);
     //   computer_play(computer);
    //} else{
     //   return printf("Player 1 has no ");
   // }
};

char user_play(struct player* target){

};