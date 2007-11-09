package # Hide from pause
   TestAppWx::default;

use strict;
use warnings;

use Test::More;
use Wx ':everything';
use Catalyst::Engine::Wx::Event qw(CAT_EVT);

use base 'Wx::Frame';

sub new {
   my ($class, $catalyst, $c ) = @_;

   my $self = $class->SUPER::new( undef, -1, 'Test', [0, 0], [475,300] );
   
   $self->Show(0);
   
   ok (ref($self) eq 'TestAppWx::default', 'TestAppWx::default');
   
   CAT_EVT( $self, '/textctrl' );
   
   return 1;
}

1;
