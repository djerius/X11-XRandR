package X11::XRandR::Geometry;

# ABSTRACT: A Screen or output geometry

use Types::Standard qw[ InstanceOf ];

use X11::XRandR::Dimension;
use X11::XRandR::Offset;

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

use overload '""' => \&to_string;

=attr dimension

An instance of L<X11::XRandR::Dimension>.

=cut


has dimension => (
    is       => 'rw',
    isa      => InstanceOf ['X11::XRandR::Dimension'],
    required => 1,
);

=attr dimension

An instance of L<X11::XRandR::Offset>.

=cut

has offset => (
    is      => 'rw',
    isa     => InstanceOf ['X11::XRandR::Offset'],
    default => sub { X11::XRandR::Offset->new },
);

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

sub to_string {
    $_[0]->dimension->to_string . $_[0]->offset->to_string;
}

1;

# COPYRIGHT
