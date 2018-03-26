package X11::Xrandr::Types;

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

declare Filter,
  as Enum [qw( bilinear nearest )];

declare Direction, as Enum [qw( normal left inverted right )];

declare Reflection, as Enum [qw( normal x y xy )];

declare SubPixelOrder,
  as Enum [
    "unknown",
    "horizontal rgb",
    "horizontal bgr",
    "vertical rgb",
    "vertical bgr",
    "no subpixels",
  ];

declare ModeFlag,
  as Enum [
    "+HSync",    "-HSync",     "+VSync", "-VSync",
    "Interlace", "DoubleScan", "CSync",  "+CSync",
    "-CSync",
  ];

declare Capability,
  as Enum [ "Source Output", "Sink Output", "Source Offload", "Sink Offload", ];

declare Connection,
  as Enum [ "connected", "disconnected", "unknown connection" ];

declare Relation, as Enum [qw( left_of right_of above below same_as )];

declare XTransform,
  as Tuple[
    Tuple[ Num, Num, Num ],
    Tuple[ Num, Num, Num ],
    Tuple[ Num, Num, Num ],
  ];
1;
