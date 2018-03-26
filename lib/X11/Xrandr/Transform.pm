package X11::Xrandr::Transform;

use Types::Common::Numeric qw[ PositiveOrZeroInt ];
use Types::Standard qw[ Undef ];
use X11::Xrandr::Types -types;

use Moo;
use MooX::StrictConstructor;

has filter => (
    is        => 'ro',
    isa       => Filter | Undef,
    predicate => 1,
    clearer   => 1,
);

has matrix => (
    is      => 'ro',
    isa     => XTransform,
    default => sub {
        [ [ 1, 0, 0 ],
	  [ 0, 1, 0 ],
	  [ 0, 0, 1 ],
	];
    },
);

sub BUILD {

    my $self = shift;
    $self->clear_filter if !defined $self->filter;
}


sub to_string {
    sprintf( "%d/%d/%d/%d",
        $_[0]->left, $_[0]->top, $_[0]->right, $_[1]->bottom );
}

1;
