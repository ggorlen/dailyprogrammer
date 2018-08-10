#!/usr/bin/perl

# 361e: https://www.reddit.com/r/dailyprogrammer/comments/8jcffg/20180514_challenge_361_easy_tally_program/

use strict;
use warnings;

sub scores {
  my ($scores) = @_;
  my %players;
  my @res;

  foreach my $c (split //, "abcde") { $players{$c} = 0; }

  foreach my $s (split //, $scores) { 
    $s =~ /[a-z]/ ? $players{$s}++ : $players{lc($s)}--; 
  }
  
  foreach my $p (sort { $players{$b} <=> $players{$a} } keys %players) {
    push @res, $p . ":" . $players{$p};
  }
  
  return (join ", ", @res) . "\n";
}

print scores("abcde"); # a:1, b:1, c:1, d:1, e:1
print scores("dbbaCEDbdAacCEAadcB"); # b:2, d:2, a:1, c:0, e:-2
print scores("EbAAdbBEaBaaBBdAccbeebaec"); # c:3, d:2, e:1, a:1, b:0
