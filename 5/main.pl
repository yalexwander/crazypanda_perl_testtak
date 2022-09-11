#!/usr/bin/env perl
use strict;
use warnings;
use Scalar::Util qw(weaken);

while (1) {
    my $a = {};
    $a->{func} = sub {
        $a->{cnt}++;
    };

    $a->{func}->();
    $a->{func}->();

    print $a->{cnt} . "\n";

    weaken($a)
}
