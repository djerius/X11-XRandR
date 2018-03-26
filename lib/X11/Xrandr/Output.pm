package X11::Xrandr::Output;

use Types::Standard -types;
use Types::Common::Numeric qw[ PositiveOrZeroNum PositiveOrZeroInt ];
use X11::Xrandr::Types -types;

use Moo;
use MooX::StrictConstructor;

use overload '""' => \&to_string;

has name => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has border => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::Border'],
    predicate => 1,
);

has clones => (
    is        => 'ro',
    isa       => ArrayRef [Str],
    predicate => 1,
);

has brightness => (
    is        => 'ro',
    isa       => Num,
    predicate => 1,
);

has connection => (
    is       => 'ro',
    isa      => Connection,
    required => 1,
);

has crtc => (
    is  => 'ro',
    isa => PositiveOrZeroInt
);

has crtcs => (
    is  => 'ro',
    isa => ArrayRef [PositiveOrZeroInt],
);

has cur_crtc => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::CurCrtc'],
    predicate => 1,
);

has cur_mode => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::CurMode'],
    predicate => 1,
);

has dimension => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::Dimension'],
    predicate => 1,
);

has gamma => (
    is        => 'ro',
    isa       => ArrayRef [PositiveOrZeroNum],
    predicate => 1,
);

has identifier => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

has timestamp => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

has subpixel => (
    is       => 'ro',
    isa      => SubPixelOrder,
    required => 1,
);

has rotations => (
    is       => 'ro',
    isa      => ArrayRef [Direction],
    required => 1,
);

has reflection => (
    is       => 'ro',
    isa      => Reflection,
    required => 1,
);

has modes => (
    is        => 'ro',
    isa       => ArrayRef [ InstanceOf ['X11::Xrandr::Mode'] ],
    predicate => 1,
);

has panning => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::Geometry'],
    predicate => 1,
);

has tracking => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::Geometry'],
    predicate => 1,
);

has transform => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Transform'],
    required => 1,
);

has primary => (
    is  => 'ro',
    isa => Bool
);

has properties => (
    is        => 'ro',
    isa       => ArrayRef [ 'X11::Xrandr::Property' ],
    predicate => 1,
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
