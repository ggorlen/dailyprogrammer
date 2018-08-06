#!/usr/bin/perl

# 325: https://www.reddit.com/r/dailyprogrammer/comments/6qutez/20170801_challenge_325_easy_color_maze/

use strict;
use warnings;

sub dfs {
    my %args = %{shift @_};
    my @directions = @{$args{dir}};
    my @maze = @{$args{maze}};
    my %visited = %{$args{visited}};
    my $w = $args{w};
    my $h = $args{h};
    my $i = ($args{i} + 1) % @directions;
    my $x = $args{x};
    my $y = $args{y};

    if ($y == 0) { 
        my %path = ("$x $y", 1);
        return \%path; 
    }

    for my $d (([-1, 0], [0, -1], [0, 1], [1, 0])) {
        $x += @{$d}[0];
        $y += @{$d}[1];

        if ($x >= 0 && $x < $w && $y >= 0 && $y < $h &&
            $maze[$y][$x] eq $directions[$i] && 
            (!exists $visited{"$x $y"} ||
            $visited{"$x $y"} < @directions)) {

            $visited{"$x $y"}++;
            my $path = dfs({
                w => $w, h => $h, 
                maze => \@maze, 
                dir => \@directions, 
                i => $i, x => $x, y => $y, 
                visited => \%visited
            });

            if ($path) {
                $path->{"$x $y"} = 1;
                return $path;
            }
        }

        $x -= @{$d}[0];
        $y -= @{$d}[1];
    }
}

sub solve {
    my $grid = shift;
    $grid =~ s/(^\s*)|( +)//g;
    my @grid = split /\n/, $grid;
    my @directions = split //, shift @grid;
    my @maze;

    for (my $i = 0; $i < @grid; $i++) {
        push @{$maze[$i]}, split //, $grid[$i];
    }

    my $w = @maze;
    my $h = @{$maze[0]};
    
    for (my $i = 0; $i < $w; $i++) {
        if (@{$maze[$h-1]}[$i] eq $directions[0]) {
            my %visited = ("$i " . ($h - 1), 1);
            my $path = dfs({
                w => $w, h => $h, 
                maze => \@maze, 
                dir => \@directions, 
                i => 0, x => $i, y => $h - 1, 
                visited=>\%visited
            });
            
            if ($path) {
                $path->{"$i ".($h-1)} = 1;

                for (my $i = 0; $i < $w; $i++) {
                    for (my $j = 0; $j < $w; $j++) {
                        if (!%$path{"$i $j"}) {
                            $maze[$j][$i] = "/";
                        }
                    }
                }

                return @maze;
            }
        }
    }    

    return @maze;
}

my @tests = ("
    O G
    B O R O Y
    O R B G R
    B O G O Y 
    Y G B Y G 
    R O R B R
", "
    R O Y P O
    R R B R R R B P Y G P B B B G P B P P R
    B G Y P R P Y Y O R Y P P Y Y R R R P P
    B P G R O P Y G R Y Y G P O R Y P B O O
    R B B O R P Y O O Y R P B R G R B G P G
    R P Y G G G P Y P Y O G B O R Y P B Y O
    O R B G B Y B P G R P Y R O G Y G Y R P
    B G O O O G B B R O Y Y Y Y P B Y Y G G
    P P G B O P Y G B R O G B G R O Y R B R
    Y Y P P R B Y B P O O G P Y R P P Y R Y
    P O O B B B G O Y G O P B G Y R R Y R B
    P P Y R B O O R O R Y B G B G O O P B Y
    B B R G Y G P Y G P R R P Y G O O Y R R
    O G R Y B P Y O P B R Y B G P G O O B P
    R Y G P G G O R Y O O G R G P P Y P B G
    P Y P R O O R O Y R P O R Y P Y B B Y R
    O Y P G R P R G P O B B R B O B Y Y B P
    B Y Y P O Y O Y O R B R G G Y G R G Y G
    Y B Y Y G B R R O B O P P O B O R R R P
    P O O O P Y G G Y P O G P O B G P R P B
    R B B R R R R B B B Y O B G P G G O O Y
");

print "\n";

for my $test (@tests) {
    for my $row (solve($test)) { print "  @{$row}\n"; }
    print "\n";
}
