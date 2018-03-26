package X11::Xrandr::ModeHorizontal;

use Types::Standard qw[ InstanceOf ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

use overload '""' => \&to_string;

has $_         => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
) for qw[ width start end total skew ];

has sync => (
    is       => 'ro',
    isa      => InstanceOf[ 'X11::Xrandr::Frequency' ],
    required => 1,
);

sub to_string {
    my $self = shift;
   sprintf ("h: width  %4d start %4d end %4d total %4d skew %4d clock %s\n",
            $self->width, $self->start, $self->end,
            $self->total, $self->skew, $self->clock->to_string );
}

1;
