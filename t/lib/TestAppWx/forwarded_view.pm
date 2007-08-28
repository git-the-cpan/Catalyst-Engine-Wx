package TestAppWx::forwarded_view;

use strict;
use warnings;

use Test::More;
use Wx ':everything';
use Catalyst::Engine::Wx::Event qw(EVT_BUTTON EVT_CLOSE EVT);

use base 'Wx::Frame';

sub new {
   my ($class, $catalyst, $c ) = @_;

   my $self = $class->SUPER::new( $c->stash->{_parent}, -1, 'Test', [105,15],[140,30] );

   ok (ref($self) eq 'TestAppWx::forwarded_view', 'TestAppWx::forwarded_view');
   
   EVT( $c->stash->{_parent}, '/shutdown' );
   
   return 1;
}

1;
