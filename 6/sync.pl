#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

use IO::Socket::INET;
use URI;

sub http_get {
    my ($host, $path, $query, $timeout) = @_;

    my $socket = IO::Socket::INET->new(
        PeerAddr => $host,
        PeerPort => '3000',
        Timeout  => $timeout,
        Proto    => 'tcp',
        Blocking => 1
    ) or die "$@";

    my $uri = URI->new('', 'http');
    $uri->query_form(%$query);
    my $query_encoded = $uri->query;

    my $message = sprintf("GET %s?%s HTTP/1.0\r\n\r\n", $path, $query_encoded);

    $socket->send($message);
    $socket->shutdown(SHUT_WR);

    my ($buffer, $length) = (1, 512);
    while ($buffer) {
        $socket->recv($buffer, $length);
        print $buffer;
    };
    $socket->close();
    
}
  
http_get("localhost", "/", { param => "value" }, 3);
