package X11::Xrandr::Screen;

use Types::Standard qw[ InstanceOf ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];

use X11::Xrandr::Types -types;

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

has id => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

has $_  => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Dimension'],
    required => 1,
) for qw[ min_dim max_dim cur_dim ];


1;
