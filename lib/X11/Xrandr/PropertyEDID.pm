package X11::Xrandr::PropertyEDID;

use Types::Standard qw[ ArrayRef InstanceOf Str ];

use Moo;
use MooX::StrictConstructor;

extends 'X11::Xrandr::Property';

use overload '""' => \&to_string;

has name => (
    is       => 'ro',
    isa      => Str,
    init_arg => undef,
    default  => 'EDID',
);

has value => (
    is       => 'ro',
    isa      => ArrayRef [Str],
    required => 1,
);

1;
