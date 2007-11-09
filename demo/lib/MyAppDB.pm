package # Hide from pause
   MyAppDB;

# Our schema needs to inherit from 'DBIx::Class::Schema'
use base qw/DBIx::Class::Schema/;

__PACKAGE__->load_classes({
   MyAppDB => [qw/Book BookAuthor Author/]
});

1;