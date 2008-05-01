package # Hide from pause
   TestAppWx::default;

use strict;
use warnings;

use Test::More;
use Wx ':everything';
use Catalyst::Engine::Wx::Event qw(CAT_EVT CAT_EVT_QUIT);

use base 'Wx::Frame';

sub new {
   my ($class, $catalyst, $c ) = @_;

   my $self = $class->SUPER::new( undef, -1, 'Test', [0, 0], [475,300] );
   
   $self->Show(1);
   
   ok (ref($self) eq 'TestAppWx::default', 'TestAppWx::default');
   
   CAT_EVT( $self, 'textctrl' );
   
   return 1;
}

sub textctrl {
   my ($self, $catalyst, $c ) = @_;

   my $testctrl = Wx::TextCtrl->new( $c->stash->{_parent}, -1, 'Test', [105,15],[140,30] );

   ok (ref($self) eq 'TestAppWx::default', 'TestAppWx::default');
   
   $c->log->info('textctrl .. ');
   
   CAT_EVT( $self, '/event_with_params', { scalar => 'data', array => ['test', 'of', 'array'] } );
   
   return 1;
}



sub shutdown {
   my ($self, $catalyst, $c ) = @_;
   
   $c->log->info('Shutting down .. ');
   
   CAT_EVT_QUIT;
   
   return;
}

1;
