#!/usr/bin/perl

# 325: https://www.reddit.com/r/dailyprogrammer/comments/8sjcl0/20180620_challenge_364_intermediate_the_ducci/

use strict;
use warnings;

sub ducci {
    my @seq = @_;
    my @seqs = ();
    push @seqs, [@seq];
    my %hist = ();

    until (exists $hist{join '; ', @seq} || join("" , @seq) == 0) {
        $hist{join '; ', @seq} = 1;
        my @next = ();

        for (my $i = 0; $i < @seq; $i++) {
            push @next, abs $seq[$i] - $seq[($i+1)%@seq];
        }

        @seq = @next;
        push @seqs, [@next];
    }

    return @seqs;
}

my @tests = (
    [0, 653, 1854, 4063],
    [1, 5, 7, 9, 9],
    [1, 2, 1, 2, 1, 0],
    [10, 12, 41, 62, 31, 50],
    [10, 12, 41, 62, 31]
);

for my $test (@tests) {
    my @seqs = ducci(@{$test});
    print "\n";
    
    for my $seq (@seqs) {
        print "[" . join('; ', @{$seq}) . "]\n";
    }
    
    print @seqs . " steps\n";
}
