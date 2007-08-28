package SampleAppWx::default;

use strict;
use warnings;

use Wx ':everything';
use Catalyst::Engine::Wx::Event qw(
   EVT_QUIT
   EVT_CLOSE
   EVT_LIST_ITEM_ACTIVATED
);

use base 'Wx::Frame';

sub new {
   my ($class, $catalyst, $c ) = @_;

   my $self = $class->SUPER::new( undef, -1, 'Books', [0, 0], [475,300] );

   my $list_ctrl = Wx::ListCtrl->new($self,-1,[3,3],[20,20],
      wxSIMPLE_BORDER|wxSUNKEN_BORDER|wxSTATIC_BORDER|wxLC_REPORT|wxLC_ALIGN_LEFT|wxLC_HRULES);

   $list_ctrl->InsertColumn( 0, "Title" );
   $list_ctrl->InsertColumn( 1, "Rating" );
   $list_ctrl->InsertColumn( 2, "Authors" );
   
   $self->Refresh();
   $self->Show(1);
   
   my $i = 0;
   foreach (@{ $c->stash->{books} }) {
      my $idx_1 = $list_ctrl->InsertStringItem( $i, $_->title );
      $list_ctrl->SetItem( $idx_1, 1, $_->rating );
      
      my $authors;
      foreach my $author ( $_->authors ) {
         $authors .= $author->first_name." ".$author->last_name.", ";
      
      }
      chop($authors);
      chop($authors);
      
      $list_ctrl->SetItem( $idx_1, 2, $authors );
   }
   
   $list_ctrl->SetColumnWidth(0, -1);
   $list_ctrl->SetColumnWidth(2, -1);
   
   Wx::LogMessage( "Welcome to Catalyst::Engine::Wx !" );
   
   EVT_LIST_ITEM_ACTIVATED( $self, $list_ctrl, 'Test::And->display' );
   EVT_CLOSE( $self, sub { EVT_QUIT; } );
   
   return 1;
}



1;
