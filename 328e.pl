# 328e: https://www.reddit.com/r/dailyprogrammer/comments/6v29zk/170821_challenge_328_easy_latin_squares/

use strict;
use warnings;

sub latin_square {
    my $n = $_[0][0];
    my @sq = split " ", $_[0][1];

    for (my $i = 0; $i < $n; $i++) {
        my @seen_col;
        my @seen_row;

        for (my $j = 0; $j < $n; $j++) {
            if ($seen_col[$sq[$n*$i+$j]] || $sq[$n*$i+$j] > $n) { 
                return 0; 
            }

            $seen_col[$sq[$n*$i+$j]]++;

            if (exists $seen_row[$sq[$n*$j+$i]] || $sq[$n*$i+$j] > $n) { 
                return 0; 
            }

            $seen_row[$sq[$n*$j+$i]]++;
        }
    }

    return 1;
}

sub reduce_latin_square {
    my $n = $_[0][0];
    my @sq = split " ", $_[0][1];
    my @square;
    push @square, [splice @sq, 0, $n] while @sq;
    return sort { $a->[0] <=> $b->[0] } @square;
}


my @tests = (
    [5, "1 2 3 4 5 5 1 2 3 4 4 5 1 2 3 3 4 5 1 2 2 3 4 5 1"],
    [2, "1 3 3 4"],
    [4, "1 2 3 4 1 3 2 4 2 3 4 1 4 3 2 1"]
);

for my $test (@tests) {
    if (latin_square($test)) {
        print "true; reduced:\n";
        print "@$_\n" for reduce_latin_square($test);
        print "\n";
    }
    else {
        print "false\n\n";
    }
}
