use strict;
use Test::More;

BEGIN {
    eval { require Wx; };
    plan skip_all => 'Wx required for this test' if $@;
    eval { require POE; };
    plan skip_all => 'POE required for this test' if $@;
}


plan tests => 2;

BEGIN { 
    use lib "./t/lib";

    $ENV{CATALYST_ENGINE} ||= 'Wx';
    require Catalyst::Engine::Wx;
}  

use strict;
use warnings;

require TestApp;

TestApp->config(
   name        => 'TestApp',
);

TestApp->setup;


TestApp->run('forward');

#TestApp->run({
#   bootstrap   => '/forward',
#});

1;
