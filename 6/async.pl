#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

use IO::Select;
use IO::Socket::INET;
use URI;


my @fill_array = ();

sub http_get {
    use vars qw( @fill_array );
    my ($host, $path, $query, $timeout) = @_;

    my $socket = IO::Socket::INET->new(
        PeerAddr => $host,
        PeerPort => '3000',
        Timeout  => $timeout,
        Proto    => 'tcp',
        Blocking => 0
    ) or die "$@";

    our $s = IO::Select->new();
    $s->add($socket);

    sub socket_can_write { defined $s->can_write(0) };
    sub socket_can_read  { defined $s->can_read(0) };

    my $uri = URI->new('', 'http');
    $uri->query_form(%$query);
    my $query_encoded = $uri->query;
    
    my $message = sprintf("GET %s?%s HTTP/1.0\r\n\r\n", $path, $query_encoded);

    while (1) {
        if (socket_can_write) {
            $socket->send($message);
            $socket->shutdown(SHUT_WR);
            last;
        }
        else {
            push @fill_array, scalar(@fill_array);
        }
    }

    my ($buffer, $length) = (1, 512);
    while (1) {
        if (socket_can_read) {
            $socket->recv($buffer, $length);
            last unless(length($buffer));
            print $buffer . "\n";
        }
        else {
            push @fill_array, scalar(@fill_array);            
        }
    }

    $socket->close();
    
}
  
http_get("localhost", "/", { param => "value" }, 3);

print Dumper(\@fill_array);
