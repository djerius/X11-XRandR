package X11::Xrandr::Geometry;

use Types::Standard qw[ InstanceOf ];

use X11::Xrandr::Dimension;
use X11::Xrandr::Offset;

use Moo;
use MooX::StrictConstructor;

use overload '""' => \&to_string;

has dimension => (
    is       => 'rw',
    isa      => InstanceOf ['X11::Xrandr::Dimension'],
    required => 1,
);

has offset => (
    is      => 'rw',
    isa     => InstanceOf ['X11::Xrandr::Offset'],
    default => sub { X11::Xrandr::Offset->new },
);

sub to_string {
    $_[0]->dimension->to_string . $_[0]->offset->to_string;
}

1;
