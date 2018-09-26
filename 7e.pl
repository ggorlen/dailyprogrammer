# 7e: https://www.reddit.com/r/dailyprogrammer/comments/pr2xr/2152012_challenge_7_easy/

use warnings;
use strict;

sub translate {
    my %table = %{$_[0]};
    my @decoded;

    for my $arr (@{$_[1]}) {
        for my $cell (@{$arr}) {
            push @decoded, $table{$cell};
        }

        push @decoded, " ";
    }

    return join "", @decoded;
}

my %alpha_to_morse = (
    a => ".-",
    b => "-...",
    c => "-.-.",
    d => "-..",
    e => ".",
    f => "..-.",
    g => "--.",
    h => "....",
    i => "..",
    j => ".---",
    k => "-.-",
    l => ".-..",
    m => "--",
    n => "-.",
    o => "---",
    p => ".--.",
    q => "--.-",
    r => ".-.",
    s => "...",
    t => "-",
    u => "..-",
    v => "...-",
    w => ".--",
    x => "-..-",
    y => "-.--",
    z => "--..",
    " " => " "
);
my %morse_to_alpha = reverse %alpha_to_morse;

my $test = ".... . .-.. .-.. --- / -.. .- .. .-.. -.-- / .--. .-. --- --. .-. .- -- -- . .-. / --. --- --- -.. / .-.. ..- -.-. -.- / --- -. / - .... . / -.-. .... .- .-.. .-.. . -. --. . ... / - --- -.. .- -.--";
my @test = map {[split / /, $_]} split / \/ /, $test;
my $translated = translate(\%morse_to_alpha, \@test);
print "$translated\n";

@test = map {[map {$_ , " "} split(//, $_)]} split / /, $translated;
print translate(\%alpha_to_morse, \@test) . "\n";
