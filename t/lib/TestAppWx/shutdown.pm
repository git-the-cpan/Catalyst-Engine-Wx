package # Hide from pause
   TestAppWx::shutdown;

use strict;
use warnings;

use Test::More;
use Wx ':everything';
use Catalyst::Engine::Wx::Event qw(CAT_EVT_QUIT);

use base 'Catalyst::View::Wx';

sub new {
   my ($class, $catalyst, $c ) = @_;

   my $self = $c->stash->{_parent};
   
   CAT_EVT_QUIT;
   
   return;
}

1;
