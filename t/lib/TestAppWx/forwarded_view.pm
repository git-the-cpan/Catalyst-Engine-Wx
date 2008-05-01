package # Hide from pause
   TestAppWx::forwarded_view;

use strict;
use warnings;

use Test::More;
use Wx ':everything';
use Catalyst::Engine::Wx::Event qw(CAT_EVT_BUTTON CAT_EVT_CLOSE CAT_EVT CAT_EVT_QUIT);

use base 'Wx::Frame';

sub new {
   my ($class, $catalyst, $c ) = @_;

   my $self = $class->SUPER::new( undef, -1, 'Test', [105,15],[140,30] );

   ok (ref($self) eq 'TestAppWx::forwarded_view', 'TestAppWx::forwarded_view');
   
   CAT_EVT( $self, 'shutdown' );
   
   return 1;
}


sub shutdown {
   my ($self, $catalyst, $c ) = @_;
   
   $c->log->info('Shutting down .. ');
   
   CAT_EVT_QUIT;
   
   return;
}

1;
