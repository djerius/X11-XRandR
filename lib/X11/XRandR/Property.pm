package X11::XRandR::Property;

# ABSTRACT: An output property

use Types::Standard qw[ ArrayRef InstanceOf Str ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

use overload '""' => \&to_string;

=attr name

=cut

has name => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

=attr value

=cut

has value => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

=attr supported

A list of supported values. Optional.

=method has_supported

I<Boolean> True if C<supported> was specified

=cut

has supported => (
    is        => 'ro',
    isa       => ArrayRef [Str],
    predicate => 1,
);

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut


1;

# COPYRIGHT
