// 276e: https://www.reddit.com/r/dailyprogrammer/comments/4tetif/20160718_challenge_276_easy_recktangles/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void shitpost(size_t s_len, char *s, unsigned int h, unsigned int w) {
    int i, j;
    int height = s_len + (s_len - 1) * (h - 1);
    int width = s_len + (s_len - 1) * (w - 1);
    int r_len = s_len-- * 2 - 2;
    char r[r_len];
    r[0] = '\0';
    strcpy(r, s);

    if (r_len > 0) {
        for (i = 1, j = r_len - 1; i < s_len; i++, j--) {
            r[j] = s[i];
        }
        
        for (i = 0; height--;) {
            for (j = 0; j < width; j++) {
                printf("%c ", height % s_len && j % s_len ? ' ' : r[i]);
                i = (i + 1) % r_len;
            }

            puts("");
        }
    }
}

int main(int argc, char **argv) {
    unsigned int h = 4;
    unsigned int w = 4;
    char s[256];
    strcpy(s, "REKT");
    
    if (argc >= 2) {
        strcpy(s, argv[1]);
    }

    if (argc >= 3) {
        h = abs(atoi(argv[2]));
    }

    if (argc == 4) {
        w = abs(atoi(argv[3]));
    }

    shitpost(strlen(s), s, h, w);
    return 0;
}
