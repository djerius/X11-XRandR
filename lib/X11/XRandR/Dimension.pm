package X11::XRandR::Dimension;

# ABSTRACT: Dimension of Screen or Display

use Types::Standard qw[ Enum ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

=attr x

=attr y

A dimension.

=cut

use overload '""' => \&to_string;
has $_            => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
) for qw[ x y ];

=attr unit

Units; either C<pixel> or C<mm>

=cut

has unit => (
             is => 'ro',
             isa => Enum[ qw[ pixel mm ] ],
             default => 'pixel',
            );

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

sub to_string {
    sprintf( "%dx%d", $_[0]->x, $_[0]->y );
}

1;

# COPYRIGHT
