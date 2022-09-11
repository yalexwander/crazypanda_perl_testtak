package DD;
use parent qw/BB CC/;

sub func {
    print "DD\n";

    my $self = shift;

    foreach my $parent (@ISA) {
        &{ $parent . '::func' }($self);
    }
}

1;
