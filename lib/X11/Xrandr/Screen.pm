package X11::Xrandr::Screen;

# ABSTRACT: A Screen

use Types::Standard qw[ InstanceOf ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];

use X11::Xrandr::Types -types;

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

=attr id

=cut

has id => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

=attr min_dim

=attr max_dim

=attr cur_dim

Instances of L<X11::Xrandr::Dimension>.

=cut

has $_  => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Dimension'],
    required => 1,
) for qw[ min_dim max_dim cur_dim ];


=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

1;

# COPYRIGHT
