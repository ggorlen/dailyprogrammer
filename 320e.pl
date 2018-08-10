# 320e: https://www.reddit.com/r/dailyprogrammer/comments/6i60lr/20170619_challenge_320_easy_spiral_ascension/

use strict;
use warnings;

sub spiral {
    my $n = shift;
    my $sq = $n * $n;
    my $i = my $j = my $c = my $dir_i = 0;
    my @dirs = ([1, 0], [0, 1], [-1, 0], [0, -1]);
    my %visited;
    my @sp;

    while ($sq--) {
        my $cell = $n * $i + $j;
        $visited{$cell} = 1;
        $sp[$cell] = ++$c;
        my $row = $i + $dirs[$dir_i][1];
        my $col = $j + $dirs[$dir_i][0];
    
        if (exists $visited{$n*$row+$col} || 
            $row + $dirs[$dir_i][1] < 0 || 
            $col < 0 || $col >= $n || $row >= $n) {

            $dir_i = ($dir_i + 1) % @dirs;
        }
    
        $i += $dirs[$dir_i][1];
        $j += $dirs[$dir_i][0];
    }

    return @sp;
}

my $n = 5;
my @spiral = spiral $n;
my $biggest = length $n * $n;

for my $i (0..@spiral - 1) {
    print((' ' x (1 + $biggest - length $spiral[$i])) . $spiral[$i]);
    if (($i + 1) % $n == 0) { print "\n"; }
}
