package # Hide from pause
   SampleApp::Model::SampleAppDB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'SampleAppDB',
    connect_info => [
        "dbi:SQLite:dbname=sampleapp.db",
        "",
        "",
        {AutoCommit => 1}
    ]
);


1;
