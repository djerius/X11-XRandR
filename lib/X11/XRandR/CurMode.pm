package X11::XRandR::CurMode;

# ABSTRACT: Current Mode

use Types::Standard qw[ InstanceOf ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];
use X11::XRandR::Types -types;

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.02';

use overload '""' => \&to_string;

=attr geometry

An instance of L<X11::XRandR::Geometry>.

=cut

has geometry => (
    is       => 'ro',
    isa      => InstanceOf ['X11::XRandR::Geometry'],
    required => 1
);

=attr rotation

For values, see L<X11::XRandR::Types/Direction>.

=cut

has rotation => (
    is       => 'ro',
    isa      => Direction,
    required => 1,
);

=attr reflection

For values, see L<X11::XRandR::Types/Reflection>. Optional.

=method has_reflection

I<Boolean>  True if L<reflection> was specified.

=cut

has reflection => (
    is        => 'ro',
    isa       => Reflection,
    predicate => 1,
);

=attr id

=cut

has id => (
    is  => 'ro',
    isa => PositiveOrZeroInt
);

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
    normal         => 'none',
    'x'            => 'X axis',
    'y'            => 'Y axis',
    'xy'           => 'X and Y axis',
);

=method map_reflection_in

Map a reflection from C<xrandr>'s nomenclature for the current mode to a L<X11::XRandR::Type/Reflection> value.

=cut

sub map_reflection_in {
    my $self = shift;
    return $MapReflectionIn{ $_[0] };
}

=method map_reflection_out

Map a L<X11::XRandR::Type/Reflection> value to C<xrandr>'s nomenclature for the current mode.

=cut

sub map_reflection_out {
    my $self = shift;
    return $MapReflectionOut{ $_[0] };
}

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

1;

# COPYRIGHT
