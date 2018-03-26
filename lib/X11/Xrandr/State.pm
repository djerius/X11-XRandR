package X11::Xrandr::State;

use Pegex::Parser;
use X11::Xrandr::Grammar::Verbose;
use X11::Xrandr::Receiver::Verbose;

use Types::Standard -types;
use IPC::Cmd;
use Carp ();

use Moo;

has screen => (
    is       => 'ro',
    isa      => InstanceOf ['X11::Xrandr::Screen'],
    required => 1,
);

has outputs => (
    is       => 'ro',
    isa      => ArrayRef [ InstanceOf ['X11::Xrandr::Output'] ],
    required => 1,
);


1;
