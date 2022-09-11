#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use Scalar::Util qw(weaken);

while (1) {
    my $a = {b => {}};
    $a->{b}{a} = $a;
    weaken($a->{b}{a});

    print Dumper($a);
}

