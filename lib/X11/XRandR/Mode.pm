package X11::XRandR::Mode;

# ABSTRACT: A Video Mode

use Types::Standard qw[ ArrayRef InstanceOf Bool Str ];
use Types::Common::Numeric qw[ PositiveOrZeroInt ];
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

=attr modeFlags

Video Mode Flags; see L<X11::XRandR::Types/ModeFlag>

=cut

has modeFlags => (
    is       => 'ro',
    isa      => ArrayRef [ModeFlag],
    required => 1,
);

=attr  width

=attr  height

=attr  hSyncStart

=attr  hSyncEnd

=attr  hTotal

=attr  hSkew

=attr  vSyncStart

=attr  vSyncEnd

=attr  vTotal

=cut

has $_ => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1
  )
  for qw[
  width
  height
  hSyncStart
  hSyncEnd
  hTotal
  hSkew
  vSyncStart
  vSyncEnd
  vTotal
];

=attr id

=cut

has id => (
    is       => 'ro',
    isa      => PositiveOrZeroInt,
    required => 1,
);

=attr dotClock

The refresh rate.  An instance of L<X11::XRandR::Frequency>.

=cut

has dotClock => (
    is       => 'ro',
    isa      => InstanceOf ['X11::XRandR::Frequency'],
    required => 1,
);

=attr hSync

The horizontal sync rate.  An instance of L<X11::XRandR::Frequency>.

=cut

has hSync => (
    is       => 'ro',
    isa      => InstanceOf ['X11::XRandR::Frequency'],
    required => 1,
);

=attr vSync

The vertical sync rate.  An instance of L<X11::XRandR::Frequency>.

=cut

has vSync => (
    is       => 'ro',
    isa      => InstanceOf ['X11::XRandR::Frequency'],
    required => 1,
);

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

=method to_XRRModeInfo

Create an XRRModeInfo object

=cut

sub to_XRRModeInfo {

    require X11::XRandR::XRRModeInfo;
    my $self = shift;

    return X11::XRandR::XRRModeInfo->new(
        width    => $self->width,
        height   => $self->height,
        dotClock => $self->dotClock->to_Hz,
        hSyncStart => $self->hSyncStart,
        hSyncEnd => $self->hSyncEnd,
        hTotal => $self->hTotal,
        hSkew => $self->hSkew,
        vSyncStart => $self->vSyncStart,
        vSyncEnd => $self->vSyncEnd,
        vTotal => $self->vTotal,
    );


}

1;

# COPYRIGHT
