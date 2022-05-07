use strict;
use warnings;
use utf8;
use sigtrap qw/die untrapped normal-signals/;

my $app = sub {
    return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'Hello World' ] ];
};
