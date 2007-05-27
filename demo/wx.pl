
BEGIN { 
    use lib "./lib";

    $ENV{CATALYST_ENGINE} ||= 'Wx';
    require Catalyst::Engine::Wx;
}  

use strict;
use warnings;

require SampleApp;

SampleApp->config(
   name        => 'SampleApp',
);

SampleApp->setup;

SampleApp->run({
   bootstrap   => '/',
});

1;
