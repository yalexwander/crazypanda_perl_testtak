package MyApp::Acessor;

our $ExportLevel = 0;
sub ExportLevel  { $ExportLevel }

sub new {
    my ($class, @args) = @_;
    my $self = bless {}, $class;

    return $self;
}

sub import {
    my ($class, @props) = @_;
    my $callpkg = caller( $class->ExportLevel );

    no strict 'refs';
    foreach my $prop (@props) {
        *{"$callpkg\::$prop"} = sub {
            if (@_ > 1) {
                $_[0]->{$prop} = $_[1];
                return $_[0];
            } else {
                return $_[0]->{$prop};  
            }
        };
    };
}


1;
