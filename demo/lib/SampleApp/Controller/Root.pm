package # Hide from pause
   SampleApp::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';
use Test::More;

__PACKAGE__->config->{namespace} = '';

sub default : Private {
   my ( $self, $c ) = @_;
   
   $c->stash->{books} = [$c->model('SampleAppDB::Book')->all];
   
   $c->forward( $c->component('Wx') );    
}


1;
