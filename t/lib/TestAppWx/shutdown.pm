package TestAppWx::shutdown;

use strict;
use warnings;

use Test::More;
use Wx ':everything';
use Catalyst::Engine::Wx::Event qw(EVT_QUIT);

use base 'Catalyst::View::Wx';

sub new {
   my ($class, $catalyst, $c ) = @_;

   my $self = $c->stash->{_parent};
   
#   ok (ref($self) eq 'TestAppWx::default', 'TestAppWx::default');

   EVT_QUIT;
   
   return;
}

1;
