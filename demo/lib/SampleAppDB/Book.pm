package # Hide from pause
   SampleAppDB::Book;

use base qw/DBIx::Class/;  

# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('books');
# Set columns in table
__PACKAGE__->add_columns(qw/id title rating/);
# Set the primary key for the table
__PACKAGE__->set_primary_key(qw/id/);

#
# Set relationships:
#

__PACKAGE__->has_many(book_authors => 'SampleAppDB::BookAuthor', 'book_id');

__PACKAGE__->many_to_many(authors => 'book_authors', 'author');

1;