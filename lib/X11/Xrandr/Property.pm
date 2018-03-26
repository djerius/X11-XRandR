package X11::Xrandr::Property;

use Types::Standard qw[ ArrayRef InstanceOf Str ];

use Moo;
use MooX::StrictConstructor;

use overload '""' => \&to_string;

has name => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has value => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has supported => (
    is        => 'ro',
    isa       => ArrayRef [Str],
    predicate => 1,
);

1;
