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
    struct hand *i = target->card_list;
    if (i == NULL) { return 0; }
    struct hand *j = i;
    int count = 0;
    char rem;
    while(i != NULL) {
        while (j != NULL) {
            if (i->top.rank == j->top.rank) {
                count++;
            }
            j = j->next;
            if (count == 4) {
                rem = i->top.rank;
                struct hand *source = target->card_list;
                if (source == NULL) { return 0; }
                while (source != NULL) {
                    if (source->top.rank == rem) {
                        remove_card(target, &source->top);
                    }
                    source = source->next;
                }
                target->book[target->score] = rem;
                target->score++;
                return rem;
            }
        }
        count = 0;
        i = i->next;
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

char computer_play(struct player* target) {
    srand((unsigned int) time(NULL));
    const char ranks[13] = {'2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'};
    int input = 1;
    while (input == 1) {
            printf("\nPlayer 2's turn, enter a Rank: ");
            int r = rand() % 13;
            char rank = ranks[r];
            printf(" %s\n", &rank);
            int numcards;
            numcards = transfer_cards(&user, target, rank);
            if (numcards == 0) {
                printf("Player 1 had no %c's\n", rank);

                struct card c = deck_instance.list[deck_size()];
                printf("Go Fish, Player 2 draws a %c%c\n\n", c.rank, c.suit);
                add_card(target, &c);
                deck_instance.numCards --;
                check_add_book(target);
                if(c.rank == rank){
                    input = 1;
                }
                else {
                    input = 0;
                }

            }
            else {
                printf("Player 1 had %d %c's\n\n", numcards, rank);
                input = 1;
                check_add_book(target);
            }
    }

}

char user_play(struct player* target){
    char rank;
    int input = 1;
    while (input == 1) {
        printf("\nPlayer 1's turn, enter a Rank: ");
        scanf(" %c", &rank);
        if ((search(target, rank)) == 1) {
            int numcards;
            numcards = transfer_cards(&computer, target, rank);
            if (numcards == 0) {
                printf("Player 2 had no %c's\n", rank);
                struct card c = deck_instance.list[deck_size()];
                printf("Go Fish, Player 1 draws a %c%c\n", c.rank, c.suit);
                add_card(target, &c);
                check_add_book(target);
                if(c.rank == rank){
                    input = 1;
                }
                else {
                    input = 0;
                }
            } else{
                printf("Player 2 had %d %c's\n", numcards, rank);
                input = 1;
                check_add_book(target);
            }

        }
        else {
            printf("Error - must have at least one card from rank to play\n");
            //printf("Player 1's turn, enter a Rank: ");
            //scanf(" %c", &rank);
            input = 1;
        }
    }

}