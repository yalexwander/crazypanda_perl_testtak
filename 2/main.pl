#!/usr/bin/env perl
use strict;
use warnings;
use lib "lib";

use DTO;

my $x = DTO->new( "label" => "X");

print $x->label . "\n";
$x->label("Y");
print $x->label . "\n";
