#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my %h;
foreach my $i (1..1_000_000) {
    $h{$i} = int(rand()*10);
}

my %vals = ();
foreach my $key (keys %h) {
    my $val = $h{$key};
    if (defined $vals{$val}) {
        delete $h{$key};
    } else {
        $vals{$val} = 1;
    }
}

print Dumper(\%h);
