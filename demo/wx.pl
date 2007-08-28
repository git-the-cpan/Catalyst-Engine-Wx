
BEGIN { 
    use lib "./lib";

    $ENV{CATALYST_ENGINE} ||= 'Wx';
    require Catalyst::Engine::Wx;
}  

use strict;
use warnings;
use Catalyst::Log::Wx;

require SampleApp;

SampleApp->config(
   name        => 'SampleApp',
);

SampleApp->log(Catalyst::Log::Wx->new);

SampleApp->setup;

SampleApp->run({
   bootstrap   => '/',
});

1;
