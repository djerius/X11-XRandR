package X11::XRandR::Frequency;

# ABSTRACT: A Frequency value

use Types::Standard qw[ Enum ];
use Types::Common::Numeric qw[ PositiveNum ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.02';

=attr value

The value

=cut


use overload '""' => \&to_string;
has value         => (
    is       => 'ro',
    isa      => PositiveNum,
    required => 1,
);

=attr unit

The unit. May be C<MHz>, C<KHz>, C<Hz>.

=cut

has unit => (
    is       => 'ro',
    isa      => Enum [qw( MHz KHz Hz )],
    required => 1,
);

=method to_Hz

Convert the value to Hz.

=cut

my %to_Hz = (
    MHz => 1e6,
    KHz => 1e3,
    Hz  => 1,
);

sub to_Hz {

    my $self = shift;

    return $self->value * $to_Hz{ $self->unit };
}


=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

sub to_string {
    sprintf( "%f%s", $_[0]->value, $_[0]->unit );
}

1;

# COPYRIGHT
