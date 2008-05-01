package # Hide from pause
   SampleAppWx::display;

use strict;
use warnings;

#use Wx ':everything';

sub new {
   my ($class, $catalyst, $c ) = @_;

   Wx::MessageBox('Hello world', 'Hello' );
}



1;
