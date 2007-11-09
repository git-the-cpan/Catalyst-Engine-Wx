package # Hide from pause
   SampleApp::View::Wx;

use strict;
use base 'Catalyst::View::Wx';

__PACKAGE__->config({
    NAMESPACE       => 'SampleAppWx',
    CATALYST_VAR    => 'Catalyst',
});


1;
