package X11::Xrandr::ModeVertical;

use Types::Standard qw[ InstanceOf ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];

use Moo;
use MooX::StrictConstructor;

use overload '""' => \&to_string;

has $_ => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
) for qw[ height start end total ];

has refresh => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Frequency'],
    required => 1,
);

sub to_string {
    my $self = shift;
    sprintf( "v: height %4d start %4d end %4d total %4d           clock %s\n",
        $self->height, $self->start, $self->end, $self->total,
        $self->refresh->to_string );
}

1;
