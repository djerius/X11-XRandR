package X11::Xrandr::Struct;

{
    package X11::Xrandr::rectangle;
    use Moo;
    use Types::Standard 'Int';
    has $_ => ( 'rw', isa => Int, ) for qw( x y width height );
}

{
    package X11::Xrandr::box;
    use Moo;

    use Types::Standard 'Int';
    has $_ => ( 'rw', isa => Int, ) for qw( x1 y1 x2 y2 );
}

{
    package X11::Xrandr::point;
    use Moo;

    use Types::Standard 'Int';
    has $_ => ( 'rw', isa => Int, ) for qw( x y );
}

{
    package X11::Xrandr::Transform;

    use X11::Xrandr::Types -types;

    has filter    => ( is => 'rw', isa => Filter );
    has transform => ( is => 'rw', isa => Transform );
    has params    => ( is => 'rw', isa => ArrayRef [XFixed] );
}

{
    package X11::Xrandr::CRTC;
    use Moo;

    has crtc_info => (
        is  => 'rw',
        isa => XRRCrtcInfo
    );

    has mode_info => (
        is  => 'rw',
        isa => XRRModeInfo,
    );

    has panning_info => (
        is  => 'rw',
        isa => XRRPanning,
    );
    has x => ( is => 'rw', isa => Int );
    has y => ( is => 'rw', isa => Int );

    has rotation => ( is => 'rw', isa => Rotation );
    has outputs => ArreyRef [Output];

    has current_transform => ( is => 'rw', isa => Transform );
    has pending_transform => ( is => 'rw', isa => Transform );
}


1;

