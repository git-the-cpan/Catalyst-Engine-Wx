package SampleApp::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';
use Test::More;

__PACKAGE__->config->{namespace} = '';

sub default : Private {
    my ( $self, $c ) = @_;
    
    $c->stash->{books} = [$c->model('SampleAppDB::Book')->all];

    $c->forward('SampleApp::View::Wx');
    print $ENV{CATALYST_ENGINE}."\n";
    #$c->forward('SampleApp::View::TT');
    
}

1;
