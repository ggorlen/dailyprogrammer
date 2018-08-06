# 323: https://www.reddit.com/r/dailyprogrammer/comments/6melen/20170710_challenge_323_easy_3sum/

use strict;
use warnings;

sub sum3 {
    @_ = map {$_ + 0} @_;
    my %triplets = ();
    my %seen = ();

    for (my $i = 0; $i < @_; $i++) { 
        $seen{$_[$i]}{$i} = 1;
    }
    
    for (my $i = 0; $i < @_; $i++) {
        for (my $j = $i + 1; $j < @_; $j++) {
            my $target = 0 - $_[$i] - $_[$j];

            if (exists $seen{$target} && 
                !exists $seen{$target}{$i} && 
                !exists $seen{$target}{$j}) {

                my @sorted = sort ($target, $_[$i], $_[$j]);
                $triplets{join " ", @sorted} = \@sorted;
            }
        }
    }

    return values %triplets;
}

my @tests = (
    "9 -6 -5 9 8 3 -4 8 1 7 -4 9 -9 1 9 -9 9 4 -6 -8",
    "4 5 -1 -2 -7 2 -5 -3 -7 -3 1",
    "-1 -6 -3 -7 5 -8 2 -8 1",
    "-5 -1 -4 2 9 -9 -6 -1 -7"
);

for my $test (@tests) {
    for my $triplet (sum3(split /\s+/, $test)) {
        print((join " ", @{$triplet}) . "\n");
    }

    print("\n");
}
