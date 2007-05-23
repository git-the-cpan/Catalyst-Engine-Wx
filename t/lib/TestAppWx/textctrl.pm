package TestAppWx::textctrl;

use strict;
use warnings;

use Test::More;
use Wx ':everything';
use Catalyst::Engine::Wx::Event qw(EVT_BUTTON EVT_CLOSE EVT);

use base 'Wx::TextCtrl';

sub new {
   my ($class, $catalyst, $c ) = @_;

   my $self = $class->SUPER::new( $c->stash->{_parent}, -1, 'Test', [105,15],[140,30] );

   ok (ref($self) eq 'TestAppWx::textctrl', 'TestAppWx::textctrl');
   
   EVT( $c->stash->{_parent}, '/event_with_params', { scalar => 'data', array => ['test', 'of', 'array'] } );
   
   return 1;
}

1;
