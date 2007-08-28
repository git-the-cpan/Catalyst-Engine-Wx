use strict;
use Test::More;

BEGIN {
    eval { require Wx; };
    plan skip_all => 'Wx required for this module' if $@;
}

plan tests => 7;

BEGIN { 
    use lib "t/lib/";

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

TestApp->run({
   bootstrap   => '/',
});

1;
