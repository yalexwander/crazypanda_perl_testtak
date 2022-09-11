package CC;
use parent 'AA';
sub func { print "CC\n"; shift->SUPER::func(@_); }

1;
