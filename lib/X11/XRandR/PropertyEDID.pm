package X11::XRandR::PropertyEDID;

# ABSTRACT: An EDID Property

use Types::Standard qw[ ArrayRef InstanceOf Str ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.02';

extends 'X11::XRandR::Property';

use overload '""' => \&to_string;

=attr name

=cut

has name => (
    is       => 'ro',
    isa      => Str,
    init_arg => undef,
    default  => 'EDID',
);

=attr value

An arrayref of EDID values

=cut

has value => (
    is       => 'ro',
    isa      => ArrayRef [Str],
    required => 1,
);

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

1;

# COPYRIGHT
