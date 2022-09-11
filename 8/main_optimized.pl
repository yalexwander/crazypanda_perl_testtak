#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use Benchmark qw(:all);

our  @data = ();
foreach my $iter (1..1_000_000) {
    push @data, scalar(@data) + 10;
}

sub find_closest_index {
    my ($value, $array) = @_;

    my $arlen = scalar(@$array);

    return $array->[0] if ($value <= $array->[0]);
    return $array->[$arlen - 1] if ($value >= $array->[$arlen - 1]);

    my ($min_index, $max_index) = (0, $arlen - 1);

    my $mid = 0;
    my $mid_value = 0;
    while (($min_index < ($max_index-1))) {
        $mid = int(($min_index + $max_index) / 2);
        $mid_value = $array->[$mid];

        if ($mid_value == $value) {
            return $mid_value;
        }
        elsif ($value < $mid_value) {
            $max_index = $mid;
        }
        else {
            $min_index = $mid;
        }
    }
}

sub test_wrapper {
    my $value = 1001;
    my $index = find_closest_index($value, \@data);
}

timethis(500000, \&test_wrapper);
