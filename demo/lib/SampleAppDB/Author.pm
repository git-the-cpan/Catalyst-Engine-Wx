package # Hide from pause
   SampleAppDB::Author;

use base qw/DBIx::Class/;

# Load required DBIC stuff
__PACKAGE__->load_components(qw/PK::Auto Core/);
# Set the table name
__PACKAGE__->table('authors');
# Set columns in table
__PACKAGE__->add_columns(qw/id first_name last_name/);
# Set the primary key for the table
__PACKAGE__->set_primary_key(qw/id/);

#
# Set relationships:
#

__PACKAGE__->has_many(book_author => 'SampleAppDB::BookAuthor', 'author_id');

__PACKAGE__->many_to_many(books => 'book_author', 'book');


1;