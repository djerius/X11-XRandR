package X11::Xrandr::Types;

# ABSTRACT: Types

use strict;
use warnings;

use Type::Utils -all;
use Types::Standard -types;

our $VERSION = '0.01';

use Type::Library
  -base,
  -declare => qw(
  Filter
  Capability
  Connection
  Direction
  Reflection
  Relation
  SubPixelOrder
  ModeFlag
  XFixed
  XTransform
);

=type Filter

C<bilinear>, C<nearest>.

=cut

declare Filter,
  as Enum [qw( bilinear nearest )];

=type Direction

C<normal>, C<left>, C<inverted>, C<right>.

=cut

declare Direction, as Enum [qw( normal left inverted right )];

=type Reflection

C<normal>, C<x>, C<y>, C<xy>.

=cut

declare Reflection, as Enum [qw( normal x y xy )];

=type SubPixelOrder

One of C<unknown>, C<horizontal rgb>, C<horizontal bgr>, C<vertical rgb>, C<vertical bgr>, C<no subpixels>.

=cut

declare SubPixelOrder,
  as Enum [
    "unknown",
    "horizontal rgb",
    "horizontal bgr",
    "vertical rgb",
    "vertical bgr",
    "no subpixels",
  ];

=type ModeFlag

Video Mode Flags:

C<+HSync>, C<-HSync>, C<+VSync>, C<-VSync>, C<Interlace>, C<DoubleScan>, C<CSync>,  C<+CSync>, C<-CSync>,

=cut

declare ModeFlag,
  as Enum [
    "+HSync",    "-HSync",     "+VSync", "-VSync",
    "Interlace", "DoubleScan", "CSync",  "+CSync",
    "-CSync",
  ];

=attr Capability

C<Source Output>, C<Sink Output>, C<Source Offload>, C<Sink Offload>

=cut

declare Capability,
  as Enum [ "Source Output", "Sink Output", "Source Offload", "Sink Offload", ];

=type Connection

One of C<connected>, C<disconnected>, C<unknown connection>.

=cut

declare Connection,
  as Enum [ "connected", "disconnected", "unknown connection" ];

declare Relation, as Enum [qw( left_of right_of above below same_as )];

=type XTransform

A transformation matrix.  Nested arrays:

  [
    [ Num, Num, Num ],
    [ Num, Num, Num ],
    [ Num, Num, Num ],
  ];

=cut

declare XTransform,
  as Tuple[
    Tuple[ Num, Num, Num ],
    Tuple[ Num, Num, Num ],
    Tuple[ Num, Num, Num ],
  ];

1;

# COPYRIGHT
