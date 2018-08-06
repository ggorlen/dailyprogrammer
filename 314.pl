# 314: https://www.reddit.com/r/dailyprogrammer/comments/69y21t/20170508_challenge_314_easy_concatenated_integers/

use strict;
use warnings;
use List::Permutor;

sub solve {
    my $max = -"inf";
    my $min = "inf";
    my $permutor = List::Permutor->new(@_);

    while (my @permutation = $permutor->next()) {
        my $candidate = join "", @permutation;
        
        if ($candidate > $max) { $max = $candidate; }
        if ($candidate < $min) { $min = $candidate; }
    }
    
    return ($min, $max);
}

my @tests = (
    "5 56 50",
    "79 82 34 83 69",
    "420 34 19 71 341",
    "17 32 91 7 46"
);

for my $test (@tests) {
    print(join(" ", solve(split /\s+/, $test)) . "\n");
}
