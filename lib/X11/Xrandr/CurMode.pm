package X11::Xrandr::CurMode;

use Types::Standard qw[ InstanceOf ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];
use X11::Xrandr::Types -types;

use Moo;
use MooX::StrictConstructor;

use overload '""' => \&to_string;

has geometry => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Geometry'],
    required => 1
);

has rotation => (
    is       => 'ro',
    isa      => Direction,
    required => 1,
);

has reflection => (
    is        => 'ro',
    isa       => Reflection,
    predicate => 1,
);

has id => (
    is  => 'ro',
    isa => PositiveOrZeroInt
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
    normal         => 'none',
    'x'            => 'X axis',
    'y'            => 'Y axis',
    'xy'           => 'X and Y axis',
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
