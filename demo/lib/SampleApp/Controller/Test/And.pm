package # Hide from pause
   SampleApp::Controller::Test::And;

use strict;
use warnings;
use base 'Catalyst::Controller';
use Test::More;

sub display : Local {
   my ( $self, $c ) = @_;
   
   #$c->stash->{class} = 'display';
   
   $c->forward( $c->component('Wx') );    
}
1;
