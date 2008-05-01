package # Hide from pause
   TestApp::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';
use Test::More;

__PACKAGE__->config->{namespace} = '';

sub default : Private {
    my ( $self, $c ) = @_;
    ok (1, 'default action');
}

sub textctrl : Local {
    my ( $self, $c ) = @_;
    ok (1, 'textctrl action');
}

sub event_with_params : Local {
    my ( $self, $c ) = @_;
    
    if (defined $c->request->parameters->{scalar}) {
        ok ($c->request->parameters->{scalar} eq 'data', 'received scalar');
    }
    
    if (defined $c->request->parameters->{array}) {
        ok ( ref( $c->request->parameters->{array} ) eq 'ARRAY', 'received array');
        ok ( $c->request->parameters->{array}[0] eq 'test', 'received array');
        
    }
       
    $c->stash->{template} = 'shutdown'; 
}

sub shutdown : Local {
    my ( $self, $c ) = @_;

    $c->log->info('controller shut down ..');    

}

sub forward : Local {
    my ( $self, $c ) = @_;
    
    ok (1, 'forwarded_view');
    $c->stash->{class} = 'forwarded_view'; 
}


sub end : Private {
    my ( $self, $c ) = @_;

    $c->forward('TestApp::View::Wx');
}


1;
