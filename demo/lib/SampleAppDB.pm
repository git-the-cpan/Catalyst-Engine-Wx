package SampleAppDB;

# Our schema needs to inherit from 'DBIx::Class::Schema'
use base qw/DBIx::Class::Schema/;

__PACKAGE__->load_classes({
   SampleAppDB => [qw/Book BookAuthor Author/]
});

1;