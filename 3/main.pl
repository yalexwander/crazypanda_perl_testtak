#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use DBI;

sub process_record {
    my ($r) = @_;

    return length($r->{text_data});
}

my $db_file = "local.db";
my $dbh = DBI->connect("dbi:SQLite:dbname=$db_file","","");

my $per_page = 10;
my $last_id_read = 0;

my $sth = $dbh->prepare("SELECT id, text_data FROM texts WHERE id > ? ORDER BY id LIMIT ?");
my $fetched = [];
my $total_chars_in_db = 0;

do {
    $sth->bind_param(1, $last_id_read);
    $sth->bind_param(2, $per_page);
    $sth->execute();

    $fetched = $sth->fetchall_arrayref({});
    $last_id_read = $fetched->[ scalar(@{$fetched}) - 1]->{"id"};

    map { $total_chars_in_db += process_record($_); } @$fetched;   
    
} while ( $per_page == scalar(@{$fetched}));


$sth->finish();
$dbh->disconnect();

print "Total chars in all records in db: " . $total_chars_in_db . "\n";
