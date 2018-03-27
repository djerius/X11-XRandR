package X11::XRandR::Output;

# ABSTRACT: A video output

use Types::Standard -types;
use Types::Common::Numeric qw[ PositiveOrZeroNum PositiveOrZeroInt ];
use X11::XRandR::Types -types;

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.02';

use overload '""' => \&to_string;

=attr name

=cut

has name => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

=attr Border

An instance of L<X11::XRandR::Border>. Optional.

=method has_Border

I<Boolean> True if L</Border> has been specified


=cut

has Border => (
    is        => 'ro',
    isa       => InstanceOf ['X11::XRandR::Border'],
    predicate => 1,
);

=attr Clones

Optional.

=method has_Clones

I<Boolean> True if L<Clones> was specified.

=cut

has Clones => (
    is        => 'ro',
    isa       => ArrayRef [Str],
    predicate => 1,
);

=attr Brightness

Optional.

=method has_Brightness

I<Boolean>  True if L<Brightness> was specified.

=cut

has Brightness => (
    is        => 'ro',
    isa       => Num,
    predicate => 1,
);

=attr connection

The state of the connection.  See L<X11::XRandR::Types/Connection> for values.

=cut

has connection => (
    is       => 'ro',
    isa      => Connection,
    required => 1,
);

=attr CRTC

The CRTC value.

=cut

has CRTC => (
    is  => 'ro',
    isa => PositiveOrZeroInt
);

=attr CRTCs

An array of CRTC values.

=cut

has CRTCs => (
    is  => 'ro',
    isa => ArrayRef [PositiveOrZeroInt],
);


=attr cur_crtc

An instance of L<X11::XRandR::CurCrtc>. Optional.

=method has_cur_crtc

I<Boolean> True if L</cur_crtc> has been specified

=cut

has cur_crtc => (
    is        => 'ro',
    isa       => InstanceOf ['X11::XRandR::CurCrtc'],
    predicate => 1,
);

=attr cur_mode

An instance of L<X11::XRandR::CurMode>. Optional.

=method has_cur_mode

I<Boolean> True if L</cur_mode> has been specified

=cut

has cur_mode => (
    is        => 'ro',
    isa       => InstanceOf ['X11::XRandR::CurMode'],
    predicate => 1,
);

=attr dimension

An instance of L<X11::XRandR::Dimension>. Optional.

=method has_dimension

I<Boolean>  True if L<dimension> was specified.

=cut

has dimension => (
    is        => 'ro',
    isa       => InstanceOf ['X11::XRandR::Dimension'],
    predicate => 1,
);

=attr Gamma

An arrayref of floats. Optional.

=method has_Gamma

I<Boolean>  True if L<Gamma> was specified.

=cut

has Gamma => (
    is        => 'ro',
    isa       => Tuple[ PositiveOrZeroNum, PositiveOrZeroNum, PositiveOrZeroNum],
    predicate => 1,
);

=attr Identifier

=cut

has Identifier => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

=attr Timestamp

=cut

has Timestamp => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

=attr Subpixel

For values, see L<X11::XRandR::Types/SubPixelOrder>.

=cut

has Subpixel => (
    is       => 'ro',
    isa      => SubPixelOrder,
    required => 1,
);

=attr rotations

An array of L<X11::XRandR::Types/Direction> values

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

An array of L<X11::XRandR::Mode> objects.

=method has_modes

I<Boolean> True if L</modes> was specified.

=cut

has modes => (
    is        => 'ro',
    isa       => ArrayRef [ InstanceOf ['X11::XRandR::Mode'] ],
    predicate => 1,
);


=attr Panning

An instance of L<X11::XRandR::Geometry>. Optional.

=method has_Panning

I<Boolean> True if L</Panning> was specified.

=cut

has Panning => (
    is        => 'ro',
    isa       => InstanceOf ['X11::XRandR::Geometry'],
    predicate => 1,
);

=attr Tracking

An instance of L<X11::XRandR::Geometry>. Optional.

=method has_Tracking

I<Boolean> True if L</Tracking> was specified.

=cut

has Tracking => (
    is        => 'ro',
    isa       => InstanceOf ['X11::XRandR::Geometry'],
    predicate => 1,
);

=attr Transform

An instance of L<X11::XRandR::Transform>.

=cut

has Transform => (
    is       => 'ro',
    isa      => InstanceOf ['X11::XRandR::Transform'],
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

An array of L<X11::XRandR::Property> objects. Optional

=method has_properties

I<Boolean> True if L</properties> was specified.

=cut

has properties => (
    is        => 'ro',
    isa       => ArrayRef [ InstanceOf['X11::XRandR::Property' ]],
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

Map a reflection from C<xrandr>'s nomenclature for an output to a L<X11::XRandR::Type/Reflection> value.

=cut

sub map_reflection_in {
    my $self = shift;
    return $MapReflectionIn{ $_[0] };
}

=method map_reflection_out

Map a L<X11::XRandR::Type/Reflection> value  to  C<xrandr>'s nomenclature for an output.

=cut

sub map_reflection_out {
    my $self = shift;
    return $MapReflectionOut{ $_[0] };
}

1;

# COPYRIGHT
