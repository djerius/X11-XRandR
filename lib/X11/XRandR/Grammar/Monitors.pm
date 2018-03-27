package X11::XRandR::Grammar::Monitors;

# ABSTRACT: The Compiled Pegex Grammar for xrandr --listmonitors output

use strict;
use warnings;

use base 'Pegex::Grammar';
use constant file => './share/monitors.pgx';

our $VERSION = '0.02';

sub make_tree {
}

1;

# COPYRIGHT
