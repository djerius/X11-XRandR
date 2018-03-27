package X11::XRandR::CurCrtc;

# ABSTRACT: Current CRTC

use Types::Standard qw[ InstanceOf ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];
use X11::XRandR::Types -types;

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.02';

use overload '""' => \&to_string;

=attr panning

An instance of L<X11::XRandR::Geometry>. Optional.

=method has_panning

I<Boolean>  True if L<panning> was specified.

=cut

has panning => (
    is       => 'ro',
    isa      => InstanceOf ['X11::XRandR::Geometry'],
                predicate => 1
);

=attr tracking

An instance of L<X11::XRandR::Geometry>. Optional.

=method has_tracking

I<Boolean>  True if L<tracking> was specified.

=cut

has tracking => (
    is       => 'ro',
    isa      => InstanceOf ['X11::XRandR::Geometry'],
                predicate => 1
);

=attr border

An instance of L<X11::XRandR::Border>. Optional.

=method has_border

I<Boolean>  True if L<border> was specified.

=cut

has border => (
    is       => 'ro',
    isa      => InstanceOf ['X11::XRandR::Border'],
                predicate => 1
);

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

sub to_string {

    my $self = shift;

    my @text;
    push @text, sprintf( "panning %s", $self->panning->to_string ) if $self->have_panning;
    push @text, sprintf( "tracking %s", $self->tracking->to_string ) if $self->have_tracking;
    push @text, sprintf( "tracking %s", $self->tracking->to_string ) if $self->have_tracking;

    return join( ' ', @text );
}

1;

# COPYRIGHT
