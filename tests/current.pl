use FindBin;
use lib "$FindBin::Bin/../lib";

use X11::Xrandr::State;

use Data::Dump;

my $state = X11::Xrandr::State->query;

dd $state;
