package X11::Xrandr::Offset;

# ABSTRACT: Offset

use Types::Standard qw[ Int ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

use overload '""' => \&to_string;

=attr x

=attr y

An offset

=cut

has $_ => (
    is      => 'ro',
    isa     => Int,
    default => 0,
) for qw[ x y ];

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

sub to_string {
    sprintf( "%+d%+d", $_[0]->x, $_[0]->y );
}

1;

# COPYRIGHT
