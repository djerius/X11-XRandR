package X11::Xrandr::Output;

# ABSTRACT: A video output

use Types::Standard -types;
use Types::Common::Numeric qw[ PositiveOrZeroNum PositiveOrZeroInt ];
use X11::Xrandr::Types -types;

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

use overload '""' => \&to_string;

=attr name

=cut

has name => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

=attr border

An instance of L<X11::Xrandr::Border>. Optional.

=method has_border

I<Boolean> True if L</border> has been specified


=cut

has border => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::Border'],
    predicate => 1,
);

=attr clones

Optional.

=method has_clones

I<Boolean> True if L<clones> was specified.

=cut

has clones => (
    is        => 'ro',
    isa       => ArrayRef [Str],
    predicate => 1,
);

=attr brightness

Optional.

=method has_brightness

I<Boolean>  True if L<brightness> was specified.

=cut

has brightness => (
    is        => 'ro',
    isa       => Num,
    predicate => 1,
);

=attr connection

The state of the connection.  See L<X11::Xrandr::Types/Connection> for values.

=cut

has connection => (
    is       => 'ro',
    isa      => Connection,
    required => 1,
);

=attr crtc

The CRTC value.

=cut

has crtc => (
    is  => 'ro',
    isa => PositiveOrZeroInt
);

=attr crtcs

An array of CRTC values.

=cut

has crtcs => (
    is  => 'ro',
    isa => ArrayRef [PositiveOrZeroInt],
);


=attr cur_crtc

An instance of L<X11::Xrandr::CurCrtc>. Optional.

=method has_cur_crtc

I<Boolean> True if L</cur_crtc> has been specified

=cut

has cur_crtc => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::CurCrtc'],
    predicate => 1,
);

=attr cur_mode

An instance of L<X11::Xrandr::CurMode>. Optional.

=method has_cur_mode

I<Boolean> True if L</cur_mode> has been specified

=cut

has cur_mode => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::CurMode'],
    predicate => 1,
);

=attr dimension

An instance of L<X11::Xrandr::Dimension>. Optional.

=method has_dimension

I<Boolean>  True if L<dimension> was specified.

=cut

has dimension => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::Dimension'],
    predicate => 1,
);

=attr gamma

An arrayref of floats. Optional.

=method has_gamma

I<Boolean>  True if L<gamma> was specified.

=cut

has gamma => (
    is        => 'ro',
    isa       => Tuple[ PositiveOrZeroNum, PositiveOrZeroNum, PositiveOrZeroNum],
    predicate => 1,
);

=attr identifier

=cut

has identifier => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

=attr timestamp

=cut

has timestamp => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

=attr subpixel

For values, see L<X11::Xrandr::Types/SubPixelOrder>.

=cut

has subpixel => (
    is       => 'ro',
    isa      => SubPixelOrder,
    required => 1,
);

=attr rotations

An array of L<X11::Xrandr::Types/Direction> values

=cut

has rotations => (
    is       => 'ro',
    isa      => ArrayRef [Direction],
    required => 1,
);

=attr reflections

An array of C<x> and/or C<y> values.

=cut

has reflections => (
    is       => 'ro',
    isa      => ArrayRef [ Enum[ 'x', 'y' ] ],
    required => 1,
);

=attr modes

An array of L<X11::Xrandr::Mode> objects.

=method has_modes

I<Boolean> True if L</modes> was specified.

=cut

has modes => (
    is        => 'ro',
    isa       => ArrayRef [ InstanceOf ['X11::Xrandr::Mode'] ],
    predicate => 1,
);


=attr panning

An instance of L<X11::Xrandr::Geometry>. Optional.

=method has_panning

I<Boolean> True if L</panning> was specified.

=cut

has panning => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::Geometry'],
    predicate => 1,
);

=attr tracking

An instance of L<X11::Xrandr::Geometry>. Optional.

=method has_tracking

I<Boolean> True if L</tracking> was specified.

=cut

has tracking => (
    is        => 'ro',
    isa       => InstanceOf ['X11::Xrandr::Geometry'],
    predicate => 1,
);

=attr transform

An instance of L<X11::Xrandr::Transform>.

=cut

has transform => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Transform'],
    required => 1,
);

=attr primary

I<Boolean>  True if the primary output.

=cut

has primary => (
    is  => 'ro',
    isa => Bool
);

=attr properties

An array of L<X11::Xrandr::Property> objects. Optional

=method has_properties

I<Boolean> True if L</properties> was specified.

=cut

has properties => (
    is        => 'ro',
    isa       => ArrayRef [ InstanceOf['X11::Xrandr::Property' ]],
    predicate => 1,
);

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

sub to_string {

    my $self = shift;

    my $string
      = sprintf( "%s (0x%x) %s", $self->geometry, $self->id, $self->rotation );

    $string .= ' ' . $self->map_reflection_out( $self->reflection )
      if $self->reflection ne 'normal';

    $string;
}

my %MapReflectionIn = (
    none           => 'normal',
    'X axis'       => 'x',
    'Y axis'       => 'y',
    'X and Y axis' => 'xy',
);

my %MapReflectionOut = (
    normal => 'none',
    'x'    => 'X axis',
    'y'    => 'Y axis',
    'xy'   => 'X and Y axis',
);

=method map_reflection_in

Map a reflection from C<xrandr>'s nomenclature for an output to a L<X11::Xrandr::Type/Reflection> value.

=cut

sub map_reflection_in {
    my $self = shift;
    return $MapReflectionIn{ $_[0] };
}

=method map_reflection_out

Map a L<X11::Xrandr::Type/Reflection> value  to  C<xrandr>'s nomenclature for an output.

=cut

sub map_reflection_out {
    my $self = shift;
    return $MapReflectionOut{ $_[0] };
}

1;

# COPYRIGHT
