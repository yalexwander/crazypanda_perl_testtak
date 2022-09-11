#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my @data = ();
foreach my $iter (1..1_000_000) {
    push @data, scalar(@data) + 10 + int(rand()*5);
}

sub find_closest_index {
    my ($value, $array) = @_;

    my $arlen = scalar(@$array);

    return $array->[0] if ($value <= $array->[0]);
    return $array->[$arlen - 1] if ($value >= $array->[$arlen - 1]);

    my ($min_index, $max_index) = (0, $arlen - 1);

    while (($min_index < ($max_index-1))) {
        my $mid = int(($min_index + $max_index) / 2);
        

        if ($array->[$mid] == $value) {
            return $array->[$mid];
        }
        elsif ($value < $array->[$mid]) {
            $max_index = $mid;
        }
        else {
            $min_index = $mid;
        }
    }
}


my $index = find_closest_index(1001, \@data);
