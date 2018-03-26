package X11::Xrandr::ModeHorizontal;

# ABSTRACT: The horizontal component of a Video Mode

use Types::Standard qw[ InstanceOf ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

use overload '""' => \&to_string;

=attr width

=attr start

=attr end

=attr total

=attr skew

=cut


has $_         => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
) for qw[ width start end total skew ];

=attr sync

An instance of L<X11::Xrandr::Frequency>.

=cut

has sync => (
    is       => 'ro',
    isa      => InstanceOf[ 'X11::Xrandr::Frequency' ],
    required => 1,
);

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

sub to_string {
    my $self = shift;
   sprintf ("h: width  %4d start %4d end %4d total %4d skew %4d clock %s\n",
            $self->width, $self->start, $self->end,
            $self->total, $self->skew, $self->clock->to_string );
}

1;

# COPYRIGHT

