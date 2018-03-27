package X11::XRandR::Border;

# ABSTRACT: Border

use Types::Common::Numeric qw[ PositiveOrZeroInt ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

use overload '""' => \&to_string;

=attr left

=attr top

=attr right

=attr bottom

=cut

has $_            => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    default  => 0
) for qw[ left top right bottom ];

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

sub to_string {
    sprintf( "%d/%d/%d/%d", $_[0]->left, $_[0]->top, $_[0]->right, $_[1]->bottom );
}

1;

# COPYRIGHT
