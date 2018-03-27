package X11::XRandR::XRRModeInfo;

# ABSTRACT: Mirror of X11 XRRModeInfo structure

use Types::Standard -types;
use Types::Common::Numeric -types;
use X11::XRandR::Types -types;


use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = "0.01";

=attr id

=cut

has id => (
    is       => 'ro',
    isa      => XID,
    required => 1,
);

=attr  width

=attr  height

=attr  dotClock

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
  dotClock
  hSyncStart
  hSyncEnd
  hTotal
  hSkew
  vSyncStart
  vSyncEnd
  vTotal
];

=attr name

=cut

has name => ( is => 'ro', isa => Str );

=attr modeFlags

Video Mode Flags; see L<X11::XRandR::Types/ModeFlag>

=cut

has modeFlags => (
    is  => 'ro',
    isa => ArrayRef [ModeFlag],
);

1;

# COPYRIGHT
