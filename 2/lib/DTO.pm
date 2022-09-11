package DTO;


use MyApp::Acessor qw( 
  label
);

sub new {
    my ($class, @args) = @_;

    my $self = bless {}, $class;

    while (my $key = shift(@args)) {
        $self->{$key} = shift @args;
    }
    
    return $self;
}

1;

