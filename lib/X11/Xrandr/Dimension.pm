package X11::Xrandr::Dimension;

use Types::Standard qw[ Enum ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];

use Moo;
use MooX::StrictConstructor;

use overload '""' => \&to_string;
has $_            => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
) for qw[ x y ];

has unit => (
	     is => 'ro',
	     isa => Enum[ qw[ pixel mm ] ],
	     default => 'pixel',
	    );

sub to_string {
    sprintf( "%dx%d", $_[0]->x, $_[0]->y );
}

1;
