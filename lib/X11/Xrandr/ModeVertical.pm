package X11::Xrandr::ModeVertical;

# ABSTRACT: The Vertical component of a Video Mode

use Types::Standard qw[ InstanceOf ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

use overload '""' => \&to_string;

=attr height

=attr start

=attr end

=attr total

=cut

has $_ => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
) for qw[ height start end total ];

=attr refresh

An instance of L<X11::Xrandr::Frequency>.

=cut

has refresh => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Frequency'],
    required => 1,
);

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

sub to_string {
    my $self = shift;
    sprintf( "v: height %4d start %4d end %4d total %4d           clock %s\n",
        $self->height, $self->start, $self->end, $self->total,
        $self->refresh->to_string );
}

1;

# COPYRIGHT
