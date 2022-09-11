package BB;
use parent 'AA';
sub func { print "BB\n"; shift->SUPER::func(@_); }

1;
