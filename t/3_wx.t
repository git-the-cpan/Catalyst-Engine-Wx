
use Test::More tests => 8;

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
