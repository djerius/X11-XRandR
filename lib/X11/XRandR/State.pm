package X11::XRandR::State;

# ABSTRACT: The XRandR state

use Pegex::Parser;
use X11::XRandR::Grammar::Verbose;
use X11::XRandR::Receiver::Verbose;

use Types::Standard -types;
use IPC::Cmd;
use Carp ();

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.02';

=attr screen

An instance of L<X11::XRandR::Screen>.

=cut

has screen => (
    is       => 'ro',
    isa      => InstanceOf ['X11::XRandR::Screen'],
    required => 1,
);

=attr outputs

An array of L<X11::XRandR::Output> objects

=cut

has outputs => (
    is       => 'ro',
    isa      => ArrayRef [ InstanceOf ['X11::XRandR::Output'] ],
    required => 1,
);

=method query

A class method to query XRandR for its state using the C<xrandr> command.
Returns an instance of L<X11::XRandR::State>.

=cut

sub query {

    IPC::Cmd::can_run( 'xrandr' )
      or Carp::croak( "xrandr command is not in path\n" );

    my ( $success, $error_message, undef, $stdout_buf, undef )
      = IPC::Cmd::run(
        command => [qw ( xrandr --verbose )],
        verbose => 0
      );

    Carp::croak( "error running xrandr: $error_message\n" )
      if length $error_message;

    my $parser = Pegex::Parser->new(
        grammar  => X11::XRandR::Grammar::Verbose->new,
        receiver => X11::XRandR::Receiver::Verbose->new
    );

    $parser->parse( join( '', @$stdout_buf ) );
}

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut


1;

# COPYRIGHT
