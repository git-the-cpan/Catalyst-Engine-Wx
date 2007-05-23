package TestAppWx::forwarded_view;

use strict;
use warnings;

use Test::More;
use Wx ':everything';
use Catalyst::Engine::Wx::Event qw(EVT_QUIT);

use base 'Wx::Frame';

sub new {
   my ($class, $catalyst, $c ) = @_;

   my $self = $class->SUPER::new( undef, -1, 'Test', [0, 0], [475,300] );
   
   $self->Show(0);
   
   ok (ref($self) eq 'TestAppWx::forwarded_view', 'TestAppWx::forwarded_view');
   
   EVT_QUIT;
   
   return 1;
}

1;
