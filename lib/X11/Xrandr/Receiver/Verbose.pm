package X11::Xrandr::Receiver::Verbose;

use strict;
use warnings;

use Carp;
use Memoize;

use base 'Pegex::Tree';

use Module::Runtime qw[ require_module ];

use String::CamelCase qw[ camelize ];

use Data::Dump qw[ dd pp ];

our %NameMap = (
    dimension_mm    => 'dimension',
);

sub remove_empty_arrays {
    scalar [ map { 'ARRAY' eq ref $_ ? ( @{$_} ? $_ : () ) : $_ } @{ $_[0] } ];
}

sub merge_hashes {
    scalar { map { %{$_} } @{ $_[0] } };
}

# cache module existence so that if the module doesn't exist, we don't
# keep looking for it.
memoize( '_require_module' );
sub _require_module {
    eval { require_module( $_[0] ); 1; };
}

sub gotrule {
    my $self = shift;
    @_ || return ();

    my $res = $_[0];
    return
      if 'ARRAY' eq ref $res && !@$res || 'HASH' eq ref $res && !keys %$res;

    my $name = $self->{parser}{rule};

    defined $NameMap{$name}
      ? $name = $NameMap{$name}
      : $name =~ s/^(EDID|frequency|screen|output_header|output|mode|cur_mode)_//;

    my ( $module_name ) = grep { _require_module( $_ ) }
      'X11::Xrandr::' . camelize( $self->{parser}{rule} ),
      'X11::Xrandr::' . camelize( $name );

    $DB::single = $name eq 'property_EDID';

# print STDERR "MODULE: $module_name: ", _require_module( $module_name ), " \n";
# $DB::single = $name eq 'panning';
    if ( defined $module_name ) {
        $res = eval { $module_name->new( $_[0] ) };
        if ( $@ ) {
            $res = $_[0];
            $self->log(
                "error instantiating $module_name from @{[ pp $_[0] ]}\n$@\n" );
        }
    }

    return $self->{parser}{parent}{-wrap}
      ? { lc $name => $res }
      : $res;
}

sub log {

    my ( $self, $msg ) = @_;

    if ( $ENV{XRANDR_DEBUG} ) {
        eval { $self->{parser}->throw_error( $msg ) };
        warn $@;
    }
    else {
        $self->{parser}->throw_error( $msg );
    }
}

sub gotrule_boolean {
    my $self = shift;
    $self->gotrule( !!@{ $_[0] } );
}


sub gotrule_unwrap_array {
    my $self = shift;
    $self->gotrule( $_[0][0] );
}


sub gotrule_merge_hashes {
    my $self = shift;
    my $hash = merge_hashes( remove_empty_arrays( shift ) );
    return unless keys %$hash;
    $self->gotrule( $hash );
}

sub dump_match {
    my $self = shift;
    dd \@_;
    $self->gotrule( @_ );
}

sub got_screen_dims {
    my $self = shift;

    my %dim = map { $_->[0] => $_->[1] } @{ $_[0] };
    return $self->gotrule( {
        max_dim => delete $dim{maximum}{dimension},
        min_dim => delete $dim{minimum}{dimension},
        cur_dim => delete $dim{current}{dimension},
    } );
}

*got_Identifier = *got_Panning = *got_Timestamp = *got_Tracking = *got_Subpixel
  = *got_Gamma = *got_CRTC = *got_CRTCs = *got_Border = *got_Brightness
  = *got_mode_sync = *got_mode_refresh = *got_filter = *got_supported = *got_ranges = *got_Clones
  = *got_panning
  = *got_property_EDID = \&gotrule_unwrap_array;

*got_xrandr = *got_output = *got_cur_mode = *got_cur_crtc = *got_geometry
  = *got_dimension     = *got_screen          
  = *got_output_header = *got_mode_horizontal = *got_mode_vertical = *got_mode
  = *got_border_values = *got_frequency       = \&gotrule_merge_hashes;

*got_mode_current = *got_mode_preferred = *got_output_primary = \&gotrule_boolean;

sub got_float {
    my $self = shift;
    $_[0] += 0;
    $self->gotrule( @_ );
}

sub got_property {
    my $self = shift;

    my %property;
    @property{'name', 'value'} = @{ $_[0][0] };

    if ( @{ $_[0] } > 1 ) {
        die( "expected exactly one key in property acceptable values:",
            dd $_[0][1] )
          if keys %{ $_[0][1] } != 1;
        my ( $key, $values ) = each %{ $_[0][1] };
        $property{$key} = $values;
    }
    $self->gotrule( \%property );
}

sub got_dimension_mm {
    my $self = shift;
    my $hash = merge_hashes( shift );
    $hash->{unit} = 'mm';
    $self->gotrule( $hash );
}

sub got_offset {
    my $self = shift;

    my ( $xm, $x, $ym, $y ) = @{ $_[0] };

    $x *= -1 if $xm eq '-';
    $y *= -1 if $ym eq '-';

    $self->gotrule( { x => $x, y => $y } );
}

sub got_Transform {
    my $self   = shift;
    my @values = @{ $_[0][0] };
    return $self->gotrule( {
            matrix =>
              [ map { [ @values[@$_] ] }[ 0, 1, 2 ], [ 3, 4, 5 ], [ 6, 7, 8 ] ],
            filter => $_[0][1] } );
}

sub got_hexint {
    my $self = shift;
    $self->gotrule( hex $_[0] );
}

use X11::Xrandr::CurMode;

sub got_cur_mode_reflection {
    my $self = shift;
    $self->gotrule( X11::Xrandr::CurMode->map_reflection_in( $_[0] ) );
}

sub got_output_header_reflection {
    my $self = shift;

    my $reflection;
    $reflection .= $_ for sort map { /(x|y)/ ; $1 } @{$_[0]};

    $self->gotrule( $reflection );
}


1;
