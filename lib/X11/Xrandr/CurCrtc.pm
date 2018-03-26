package X11::Xrandr::CurCrtc;

use Types::Standard qw[ InstanceOf ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];
use X11::Xrandr::Types -types;

use Moo;
use MooX::StrictConstructor;

use overload '""' => \&to_string;

has panning => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Geometry'],
		predicate => 1
);

has tracking => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Geometry'],
		predicate => 1
);

has border => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Border'],
		predicate => 1
);

sub to_string {

    my $self = shift;

    my @text;
    push @text, sprintf( "panning %s", $self->panning->to_string ) if $self->have_panning;
    push @text, sprintf( "tracking %s", $self->tracking->to_string ) if $self->have_tracking;
    push @text, sprintf( "tracking %s", $self->tracking->to_string ) if $self->have_tracking;

    return join( ' ', @text );
}

1;
