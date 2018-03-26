package X11::Xrandr::Frequency;

use Types::Standard qw[ Enum ];
use Types::Common::Numeric qw[ PositiveNum ];

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

use overload '""' => \&to_string;
has value         => (
    is       => 'ro',
    isa      => PositiveNum,
    required => 1,
);

has unit => (
    is       => 'ro',
    isa      => Enum [qw( MHz KHz Hz )],
    required => 1,
);

sub to_string {
    sprintf( "%f%s", $_[0]->value, $_[0]->unit );
}

1;
