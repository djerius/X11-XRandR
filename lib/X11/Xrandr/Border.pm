package X11::Xrandr::Border;

use Types::Common::Numeric qw[ PositiveOrZeroInt ];

use Moo;
use MooX::StrictConstructor;

use overload '""' => \&to_string;
has $_            => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    default  => 0
) for qw[ left top right bottom ];

sub to_string {
    sprintf( "%d/%d/%d/%d", $_[0]->left, $_[0]->top, $_[0]->right, $_[1]->bottom );
}

1;
