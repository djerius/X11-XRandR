package X11::Xrandr::Offset;

use Types::Standard qw[ Int ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

use overload '""' => \&to_string;

has $_ => (
    is      => 'ro',
    isa     => Int,
    default => 0,
) for qw[ x y ];

sub to_string {
    sprintf( "%+d%+d", $_[0]->x, $_[0]->y );
}

1;
