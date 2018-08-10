#!/usr/bin/perl

# 321e: https://www.reddit.com/r/dailyprogrammer/comments/6jr76h/20170627_challenge_321_easy_talking_clock/

use strict;
use warnings;
use Win32::OLE;

sub talk {
    my ($h, $m) = split /:/, $_[0];
    my ($tens, $ones) = split //, $m;
    my @t = (
        "twelve", "one", "two", "three", 
        "four", "five", "six", "seven",
        "eight", "nine", "ten", "eleven", 
        "twelve", "thirteen", "fourteen",
        "fifteen", "sixteen", "seventeen", 
        "eighteen", "nineteen", "twenty"
    );
    @t[30] = "thirty";
    @t[40] = "forty";
    @t[50] = "fifty";
    return "It's $t[$h%12]" . ($m == 0 ? "" : 
        $m < 10 ? " oh $t[$m]" : $m < 20 ? 
        " $t[$m]" : " $t[$tens*10]" . 
        ($ones > 0 ? " $t[$ones]" : "")) . 
        ($h < 12 ? " am" : " pm");
}

my @tests = (
    "00:00",
    "01:30",
    "12:05",
    "14:01",
    "20:29",
    "21:00"
);
my @expected = (
    "It's twelve am",
    "It's one thirty am",
    "It's twelve oh five pm",
    "It's two oh one pm",
    "It's eight twenty nine pm",
    "It's nine pm"
);
my $voice = Win32::OLE->CreateObject('SAPI.SpVoice');

foreach my $test (@tests) {
    my $time = talk($test);
    print "$time\n";
    $time =~ s/ am/ a m/;
    $voice->Speak($time);
}
