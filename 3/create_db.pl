#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use DBI;

my $db_file = "local.db";

system "rm -f \"$db_file\"";
system "sqlite3 \"$db_file\" < db_init.sql";

my $dbh = DBI->connect("dbi:SQLite:dbname=$db_file","","");

$dbh->do("PRAGMA journal_mode = WAL");
$dbh->do("PRAGMA synchronous = NORMAL");

my $sth = $dbh->prepare("insert into texts(text_data) VALUES(?)");
foreach my $tv (0..10000) {
    $sth->bind_param(1, sprintf("%08X\n", rand(0xffffffff)));
    $sth->execute();
}
$sth->finish();
$dbh->disconnect();
