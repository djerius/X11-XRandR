package X11::Xrandr::State;

use Pegex::Parser;
use X11::Xrandr::Grammar::Verbose;
use X11::Xrandr::Receiver::Verbose;

use Types::Standard -types;
use IPC::Cmd;
use Carp ();

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

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

sub query {

    my $class = shift;

    IPC::Cmd::can_run( 'xrandr' )
      or Carp::croak( "xrandr command is not in path\n" );

    my ( $success, $error_message, $full_buf, $stdout_buf, $stderr_buf )
      = IPC::Cmd::run(
        command => [qw ( xrandr --verbose )],
        verbose => 0
      );

    Carp::croak( "error running xrandr: $error_message\n" )
      if length $error_message;

    my $parser = Pegex::Parser->new(
        grammar  => X11::Xrandr::Grammar::Verbose->new,
        receiver => X11::Xrandr::Receiver::Verbose->new
    );

    $parser->parse( join( '', @$stdout_buf ) );
}


1;
