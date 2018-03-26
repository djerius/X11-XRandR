package X11::Xrandr::Mode;

use Types::Standard qw[ ArrayRef InstanceOf Bool Str ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];
use X11::Xrandr::Types -types;

use Moo;
use MooX::StrictConstructor;

use overload '""' => \&to_string;

has name => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has current => (
    is  => 'ro',
    isa => Bool,
);

has preferred => (
    is  => 'ro',
    isa => Bool,
);

has flags => (
    is       => 'ro',
    isa      => ArrayRef [ModeFlag],
    required => 1,
);

has horizontal => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::ModeHorizontal'],
    required => 1,
);

has vertical => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::ModeVertical'],
    required => 1,
);

has id => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

has refresh => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Frequency'],
    required => 1,
);

sub to_string {

    my $self = shift;

    my $string
      = sprintf( "%s (0x%x) %s", $self->geometry, $self->id, $self->rotation );

    $string .= ' ' . $self->map_reflection_out( $self->reflection )
      if $self->reflection ne 'normal';

    $string;
}

my %MapReflectionIn = (
    none           => 'normal',
    'X axis'       => 'x',
    'Y axis'       => 'y',
    'X and Y axis' => 'xy',
);

my %MapReflectionOut = (
    normal => 'none',
    'x'    => 'X axis',
    'y'    => 'Y axis',
    'xy'   => 'X and Y axis',
);

sub map_reflection_in {
    my $self = shift;
    return $MapReflectionIn{ $_[0] };
}
sub map_reflection_out {
    my $self = shift;
    return $MapReflectionOut{ $_[0] };
}

1;
