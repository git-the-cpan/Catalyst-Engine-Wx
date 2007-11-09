package # Hide from pause
   TestApp::View::Wx;

use strict;
use base 'Catalyst::View::Wx';

__PACKAGE__->config({
    NAMESPACE       => 'TestAppWx',
    CATALYST_VAR    => 'Catalyst',
});


1;
