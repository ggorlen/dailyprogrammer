# 355e: https://www.reddit.com/r/dailyprogrammer/comments/879u8b/20180326_challenge_355_easy_alphabet_cipher/

use strict;
use warnings;

sub encrypt {
    my @kw = split "", shift @_;
    my @msg = split "", shift @_;
    my $dir = $_[0] ? -1 : 1; # encode / decode

    for (my $i = 0; $i < @msg; $i++) {
        $msg[$i] = chr((ord($msg[$i]) - 97 + $dir * (ord($kw[$i%@kw]) - 97)) % 26 + 97);
    }

    return join "", @msg;
}

my @tests = (
    ["snitch thepackagehasbeendelivered", "lumicjcnoxjhkomxpkwyqogywq", 0],
    ["bond theredfoxtrotsquietlyatmidnight", "uvrufrsryherugdxjsgozogpjralhvg", 0],
    ["train murderontheorientexpress", "flrlrkfnbuxfrqrgkefckvsa", 0],
    ["garden themolessnuckintothegardenlastnight", "zhvpsyksjqypqiewsgnexdvqkncdwgtixkx", 0],
    ["cloak klatrgafedvtssdwywcyty", "iamtheprettiestunicorn", 1],
    ["python pjphmfamhrcaifxifvvfmzwqtmyswst", "alwayslookonthebrightsideoflife", 1],
    ["moore rcfpsgfspiecbcc", "foryoureyesonly", 1]
);

for my $test (@tests) {
    my $res = encrypt((split /\s+/, @{$test}[0]), @{$test}[2]);

    if ($res ne @{$test}[1]) {
        print "test failed (expected @{$test}[1] but got $res)\n";
        exit;
    }
}
