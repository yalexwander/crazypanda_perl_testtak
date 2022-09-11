#!/usr/bin/env perl
use strict;
use warnings;
use Scalar::Util qw(weaken);

my $a = {};

while (1) {  

    delete $a->{func} if defined($a->{func});
    
    $a->{func} = sub {
        $a->{cnt}++;
    };

    $a->{func}->();

    print $a->{cnt} . "\n";
}
