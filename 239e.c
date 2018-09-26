// 239e: https://www.reddit.com/r/dailyprogrammer/comments/3r7wxz/20151102_challenge_239_easy_a_game_of_threes/

#include <stdio.h>

void game_of_threes(int n) {
    while (n > 1) {
        printf("%d ", n);

        if (n % 3 == 0) {
            puts("0");
            n /= 3;
        }
        else if ((n + 1) % 3 == 0) {
            puts("1");
            n = (n + 1) / 3;
        }
        else {
            puts("-1");
            n = (n - 1) / 3;
        }
    }

    printf("%d ", n);
}

int main(int argv, char **args) {
    game_of_threes(argv > 1 ? atoi(args[1]) : 31337357);
    return 0;
}
