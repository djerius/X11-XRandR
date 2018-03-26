package X11::Xrandr::Mode;

# ABSTRACT: A Video Mode

use Types::Standard qw[ ArrayRef InstanceOf Bool Str ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];
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

=attr current

I<Boolean> is this the current mode?

=cut

has current => (
    is  => 'ro',
    isa => Bool,
);

=attr preferred

I<Boolean> is this the preferred mode?

=cut

has preferred => (
    is  => 'ro',
    isa => Bool,
);

=attr flags

Video Mode Flags; see L<X11::Xrandr::Types/ModeFlag>

=cut

has flags => (
    is       => 'ro',
    isa      => ArrayRef [ModeFlag],
    required => 1,
);

=attr horizontal

The horizontal component of the mode.  An instance of
C<X11::Xrandr::ModeHorizontal>.

=cut

has horizontal => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::ModeHorizontal'],
    required => 1,
);

=attr vertical

The vertical component of the mode.  An instance of
C<X11::Xrandr::ModeVertical>.

=cut

has vertical => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::ModeVertical'],
    required => 1,
);

=attr id

=cut

has id => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

=attr refresh

The refresh rate.  An instance of L<X11::Xrandr::Frequency>.

=cut

has refresh => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Frequency'],
    required => 1,
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

Map a reflection from C<xrandr>'s nomenclature for a mode to a L<X11::Xrandr::Type/Reflection> value

=cut

sub map_reflection_in {
    my $self = shift;
    return $MapReflectionIn{ $_[0] };
}

=method map_reflection_out

Map a L<X11::Xrandr::Type/Reflection> value to C<xrandr>'s nomenclature for a mode.

=cut

sub map_reflection_out {
    my $self = shift;
    return $MapReflectionOut{ $_[0] };
}

1;

# COPYRIGHT
