package # Hide from pause
   SampleAppDB::BookAuthor;

use base qw/DBIx::Class/;

# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('book_authors');
# Set columns in table
__PACKAGE__->add_columns(qw/book_id author_id/);
# Set the primary key for the table
__PACKAGE__->set_primary_key(qw/book_id author_id/);

#
# Set relationships:
#
__PACKAGE__->belongs_to(book => 'SampleAppDB::Book', 'book_id');

__PACKAGE__->belongs_to(author => 'SampleAppDB::Author', 'author_id');


1;