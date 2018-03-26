package X11::Xrandr::Transform;

# ABSTRACT: A transform

use Types::Common::Numeric qw[ PositiveOrZeroInt ];
use Types::Standard qw[ Undef ];
use X11::Xrandr::Types -types;

use Moo;
use namespace::clean;
use MooX::StrictConstructor;

our $VERSION = '0.01';

=attr filter

See L<X11::Xrandr::Types/Filter> for values.  Optional

=method has_filter

I<Boolean>  True if L<filter> was specified.

=cut

has filter => (
    is        => 'ro',
    isa       => Filter | Undef,
    predicate => 1,
    clearer   => 1,
);

=attr matrix

A transformation matrix.  See L<X11::Xrandr::Types/XTransform>.

=cut

has matrix => (
    is      => 'ro',
    isa     => XTransform,
    default => sub {
        [ [ 1, 0, 0 ],
          [ 0, 1, 0 ],
          [ 0, 0, 1 ],
        ];
    },
);


=for Pod::Coverage BUILD

=cut

sub BUILD {

    my $self = shift;
    $self->clear_filter if !defined $self->filter;
}

=method to_string

Return a string rendition of the object just as B<xrandr> would.

=cut

sub to_string {
    sprintf( "%d/%d/%d/%d",
        $_[0]->left, $_[0]->top, $_[0]->right, $_[1]->bottom );
}

1;

# COPYRIGHT

