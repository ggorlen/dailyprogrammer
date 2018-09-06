use 5.010;
use strict;
use warnings;
use LWP::UserAgent;

sub funnel {
    my @a = split //, shift;
    my @b = split //, shift;
    
    if (@a - 1 == @b) {
        for my $i (0..@a-1) {
            my $letter = splice @a, $i, 1;
        
            if (@a ~~ @b) {
                return 1;
            }
        
            splice @a, $i, 0, $letter;
        }
    }

    return 0;
}

sub bonus {
    my @word = split //, $_[0];
    my $lookup = $_[1];
    my %res;

    for my $i (0..@word-1) {
        my $letter = splice @word, $i, 1;
        my $s = join '', @word;
    
        if ($lookup->{$s}) {
            $res{$s} = 1;
        }
    
        splice @word, $i, 0, $letter;
    }

    return keys %res;
}


my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new(GET => 'https://raw.githubusercontent.com/dolph/dictionary/master/enable1.txt');
my @words = split /\n/, $ua->request($req)->content;
my %lookup = map { $_ => 1 } @words;

my @basic_tests = (
    ["leave", "eave", 1],
    ["reset", "rest", 1],
    ["dragoon", "dragon", 1],
    ["eave", "leave", 0],
    ["sleet", "lets", 0],
    ["skiff", "ski", 0]
);

for my $test (@basic_tests) {
    print "fail\n" if funnel(@{$test}[0], @{$test}[1]) != @{$test}[2];
}

my $count = 0;

for my $word (@words) {
    if (length $word >= 5 && bonus($word, \%lookup) >= 5) {
        print "$word\n";
        $count++;
    }
}

print "$count words can be funneled >= 5 ways\n";
