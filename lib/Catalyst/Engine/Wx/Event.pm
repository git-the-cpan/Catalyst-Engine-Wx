package Catalyst::Engine::Wx::Event;

use strict;
use vars qw(@ISA @EXPORT_OK);

use Exporter;

@ISA = qw(Exporter);
#@EXPORT_OK = qw();

# !parser: sub { $_[0] =~ m/sub (EVT_\w+)/ }
# !package: Wx::Event
  
sub EVT_QUIT { 
   POE::Kernel->post('catalyst-wxperl', '_stop');
}

sub EVT { 
   my $parent     = $_[0];
   my $controller = $_[1];
   my $params     = $_[2] || {};

   $params->{'controller'} = $controller;
   $params->{'parent'}     = $parent;

   POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', $params);
}

#
# ActivateEvent
#

sub EVT_ACTIVATE($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_ACTIVATE_APP($$) {  
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE_APP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE_APP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# CommandEvent
#
sub EVT_COMMAND_RANGE($$$$$) { $_[0]->Connect( $_[1], $_[2], $_[3], $_[4] ) } # FIX ME !!
sub EVT_BUTTON($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_BUTTON_CLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_BUTTON_CLICKED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_CHECKBOX($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHECKBOX_CLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHECKBOX_CLICKED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_CHOICE($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICE_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICE_SELECTED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_LISTBOX($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOX_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOX_SELECTED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LISTBOX_DCLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_TEXT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_UPDATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_UPDATED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
# ------------------------------------------------------------------------------------------------------
sub EVT_TEXT_ENTER($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_ENTER, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_ENTER, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_TEXT_MAXLEN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_MAXLEN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_MAXLEN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_TEXT_URL($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_URL, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_URL, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_MENU($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_MENU_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_MENU_SELECTED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
# NEEDS FIX !!
sub EVT_MENU_RANGE($$$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_MENU_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_MENU_SELECTED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_SLIDER($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SLIDER_UPDATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SLIDER_UPDATED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_RADIOBOX($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RADIOBOX_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RADIOBOX_SELECTED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_RADIOBUTTON($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RADIOBUTTON_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RADIOBUTTON_SELECTED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_SCROLLBAR($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SCROLLBAR_UPDATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SCROLLBAR_UPDATED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_COMBOBOX($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_COMBOBOX_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_COMBOBOX_SELECTED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_TOOL($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_CLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_CLICKED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
# NEEDS FIX !!
sub EVT_TOOL_RANGE($$$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_CLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_CLICKED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_TOOL_RCLICKED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_RCLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_RCLICKED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
# NEEDS FIX !!
sub EVT_TOOL_RCLICKED_RANGE($$$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_RCLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_RCLICKED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_TOOL_ENTER($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_ENTER, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_ENTER, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_COMMAND_LEFT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LEFT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LEFT_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_COMMAND_LEFT_DCLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LEFT_DCLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LEFT_DCLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_COMMAND_RIGHT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RIGHT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_COMMAND_SET_FOCUS($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SET_FOCUS, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SET_FOCUS, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_COMMAND_KILL_FOCUS($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_KILL_FOCUS, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_KILL_FOCUS, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_COMMAND_ENTER($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_ENTER, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_ENTER, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_TOGGLEBUTTON($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_CHECKLISTBOX($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHECKLISTBOX_TOGGLED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHECKLISTBOX_TOGGLED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   } 
}
sub EVT_TEXT_CUT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_CUT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_CUT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_TEXT_COPY($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_COPY, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_COPY, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}
sub EVT_TEXT_PASTE($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_PASTE, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_PASTE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      }); 
   }
}

#
# CloseEvent
#
sub EVT_CLOSE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CLOSE_WINDOW, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CLOSE_WINDOW, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });  
   }
}
sub EVT_END_SESSION($$) {
   if (ref $_[1] eq 'CODE') { 
      $_[0]->Connect( -1, -1, &Wx::wxEVT_END_SESSION, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_END_SESSION, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });  
   }
}
sub EVT_QUERY_END_SESSION($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_QUERY_END_SESSION, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_QUERY_END_SESSION, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });  
   }
}

#
# DropFilesEvent
#

sub EVT_DROP_FILES($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_DROP_FILES, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_DROP_FILES, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });  
   }
}

#
# EraseEvent
#
sub EVT_ERASE_BACKGROUND($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ERASE_BACKGROUND, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ERASE_BACKGROUND, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });  
   }
}

#
# FindDialogEvent
#
sub EVT_FIND($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_FIND_NEXT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_NEXT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_NEXT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_FIND_REPLACE($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_REPLACE, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_REPLACE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_FIND_REPLACE_ALL($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_REPLACE_ALL, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_REPLACE_ALL, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_FIND_CLOSE($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_CLOSE, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_CLOSE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# FocusEvent
#
sub EVT_SET_FOCUS($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SET_FOCUS, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SET_FOCUS, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_KILL_FOCUS($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KILL_FOCUS, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KILL_FOCUS, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# KeyEvent
#

sub EVT_CHAR($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CHAR, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CHAR, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_CHAR_HOOK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CHAR_HOOK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CHAR_HOOK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_KEY_DOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KEY_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KEY_DOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_KEY_UP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KEY_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KEY_UP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# Grid*Event
#

sub EVT_GRID_CELL_LEFT_CLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_LEFT_CLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_LEFT_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_CELL_RIGHT_CLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_RIGHT_CLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_CELL_LEFT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_LEFT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_LEFT_DCLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_CELL_RIGHT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_RIGHT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_RIGHT_DCLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_LABEL_LEFT_CLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_LEFT_CLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_LEFT_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_LABEL_RIGHT_CLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_RIGHT_CLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_LABEL_LEFT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_LEFT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_LEFT_DCLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_LABEL_RIGHT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_RIGHT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_RIGHT_DCLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_ROW_SIZE($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_ROW_SIZE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_ROW_SIZE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_COL_SIZE($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_COL_SIZE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_COL_SIZE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_RANGE_SELECT($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_RANGE_SELECT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_RANGE_SELECT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_CELL_CHANGE($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_CHANGE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_CHANGE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_SELECT_CELL($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_SELECT_CELL, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_SELECT_CELL, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_EDITOR_SHOWN($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_SHOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_SHOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_EDITOR_HIDDEN($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_HIDDEN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_HIDDEN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_GRID_EDITOR_CREATED($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_CREATED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_CREATED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# HelpEvent
#

sub EVT_HELP($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_HELP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_HELP_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_HELP, $_[3] ) } # FIX ME !!!!
sub EVT_DETAILED_HELP($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_DETAILED_HELP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_DETAILED_HELP_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_DETAILED_HELP, $_[3] ) } # FIX ME !!!!

#
# IconizeEvent
#

sub EVT_ICONIZE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ICONIZE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ICONIZE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# IdleEvent
#

sub EVT_IDLE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_IDLE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_IDLE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# InitDialogEvent
#

sub EVT_INIT_DIALOG($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_INIT_DIALOG, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_INIT_DIALOG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# JoystickEvent
#

sub EVT_JOY_BUTTON_DOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_BUTTON_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_BUTTON_DOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_JOY_BUTTON_UP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_BUTTON_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_BUTTON_UP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_JOY_MOVE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_MOVE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_MOVE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_JOY_ZMOVE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_ZMOVE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_ZMOVE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# ListbookEvent
#

sub EVT_LISTBOOK_PAGE_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LISTBOOK_PAGE_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# ChoicebookEvent
#

sub EVT_CHOICEBOOK_PAGE_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_CHOICEBOOK_PAGE_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# ToolbookEvent
#

sub EVT_TOOLBOOK_PAGE_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TOOLBOOK_PAGE_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# TreebookEvent
#
sub EVT_TREEBOOK_PAGE_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREEBOOK_PAGE_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREEBOOK_NODE_COLLAPSED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREEBOOK_NODE_EXPANDED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# ListEvent
#
sub EVT_LIST_BEGIN_DRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_DRAG, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_BEGIN_RDRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_RDRAG, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_RDRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_BEGIN_LABEL_EDIT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_CACHE_HINT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_CACHE_HINT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_CACHE_HINT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_END_LABEL_EDIT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_END_LABEL_EDIT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_END_LABEL_EDIT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_DELETE_ITEM($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_DELETE_ITEM, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_DELETE_ITEM, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_DELETE_ALL_ITEMS($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_GET_INFO($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_GET_INFO, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_GET_INFO, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_SET_INFO($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_SET_INFO, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_SET_INFO, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_ITEM_SELECTED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_SELECTED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_ITEM_DESELECTED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_DESELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_DESELECTED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_KEY_DOWN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_KEY_DOWN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_KEY_DOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_INSERT_ITEM($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_INSERT_ITEM, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_INSERT_ITEM, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_COL_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_RIGHT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_RIGHT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_MIDDLE_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_MIDDLE_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_MIDDLE_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_ITEM_ACTIVATED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_ACTIVATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_ACTIVATED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_COL_RIGHT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_RIGHT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_COL_BEGIN_DRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_BEGIN_DRAG, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_COL_DRAGGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_DRAGGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_DRAGGING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_COL_END_DRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_END_DRAG, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_END_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_ITEM_FOCUSED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_FOCUSED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_FOCUSED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_LIST_ITEM_RIGHT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# MenuEvent
#

sub EVT_MENU_CHAR($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CHAR, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CHAR, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MENU_INIT($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_INIT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_INIT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MENU_HIGHLIGHT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_MENU_HIGHLIGHT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_MENU_HIGHLIGHT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_POPUP_MENU($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_POPUP_MENU, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_POPUP_MENU, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_CONTEXT_MENU($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CONTEXT_MENU, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CONTEXT_MENU, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MENU_OPEN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_OPEN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_OPEN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MENU_CLOSE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CLOSE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CLOSE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# MouseEvent
#
sub EVT_LEFT_DOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_DOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_LEFT_UP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_UP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_LEFT_DCLICK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_DCLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MIDDLE_DOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_DOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MIDDLE_UP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_UP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MIDDLE_DCLICK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_DCLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_RIGHT_DOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_DOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_RIGHT_UP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_UP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_RIGHT_DCLICK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_DCLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MOTION($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOTION, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOTION, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_ENTER_WINDOW($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ENTER_WINDOW, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ENTER_WINDOW, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_LEAVE_WINDOW($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEAVE_WINDOW, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEAVE_WINDOW, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MOUSEWHEEL($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOUSEWHEEL, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOUSEWHEEL, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MOUSE_EVENTS($$) {
  my( $x, $y ) = @_;
  EVT_LEFT_DOWN( $x, $y );
  EVT_LEFT_UP( $x, $y );
  EVT_LEFT_DCLICK( $x, $y );
  EVT_MIDDLE_DOWN( $x, $y );
  EVT_MIDDLE_UP( $x, $y );
  EVT_MIDDLE_DCLICK( $x, $y );
  EVT_RIGHT_DOWN( $x, $y );
  EVT_RIGHT_UP( $x, $y );
  EVT_RIGHT_DCLICK( $x, $y );
  EVT_MOTION( $x, $y );
  EVT_ENTER_WINDOW( $x, $y );
  EVT_LEAVE_WINDOW( $x, $y );
  EVT_MOUSEWHEEL( $x, $y );
}

#
# MoveEvent
#

sub EVT_MOVE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOVE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOVE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_MOVING($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOVING, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOVING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# NotebookEvent
#

sub EVT_NOTEBOOK_PAGE_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_NOTEBOOK_PAGE_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# PaintEvent
#

sub EVT_PAINT($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_PAINT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_PAINT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# ProcessEvent
#

sub EVT_END_PROCESS($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_END_PROCESS, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_END_PROCESS, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# SashEvent
#
sub EVT_SASH_DRAGGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SASH_DRAGGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SASH_DRAGGED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_SASH_DRAGGED_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_SASH_DRAGGED, $_[3] ) }

#
# SizeEvent
#

sub EVT_SIZE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SIZE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SIZING($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SIZING, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# ScrollEvent
#

sub EVT_SCROLL_TOP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLL_BOTTOM($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_BOTTOM, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLL_LINEUP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_LINEUP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLL_LINEDOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_LINEDOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLL_PAGEUP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_PAGEUP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLL_PAGEDOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_PAGEDOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLL_THUMBTRACK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_THUMBTRACK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLL_THUMBRELEASE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_THUMBRELEASE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

sub EVT_COMMAND_SCROLL_TOP($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_TOP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_COMMAND_SCROLL_BOTTOM($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_BOTTOM, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_BOTTOM, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_COMMAND_SCROLL_LINEUP($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_COMMAND_SCROLL_LINEDOWN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEDOWN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEDOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   } 
}
sub EVT_COMMAND_SCROLL_PAGEUP($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEUP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_COMMAND_SCROLL_PAGEDOWN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEDOWN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEDOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_COMMAND_SCROLL_THUMBTRACK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBTRACK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBTRACK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_COMMAND_SCROLL_THUMBRELEASE($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBRELEASE, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBRELEASE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# ScrollWinEvent
#
sub EVT_SCROLLWIN_TOP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_TOP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLLWIN_BOTTOM($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_BOTTOM, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLLWIN_LINEUP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_LINEUP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLLWIN_LINEDOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_LINEDOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLLWIN_PAGEUP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_PAGEUP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLLWIN_PAGEDOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_PAGEDOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLLWIN_THUMBTRACK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_THUMBTRACK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_SCROLLWIN_THUMBRELEASE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_THUMBRELEASE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# SpinEvent
#

sub EVT_SPIN_UP($$$) { 
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_SPIN_DOWN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEDOWN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEDOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_SPIN($$$) { 
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_THUMBTRACK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBTRACK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_SPINCTRL($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_SPINCTRL_UPDATED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPINCTRL_UPDATED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# SplitterEvent
#
sub EVT_SPLITTER_SASH_POS_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_SPLITTER_SASH_POS_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_SPLITTER_UNSPLIT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_SPLITTER_UNSPLIT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_UNSPLIT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   } 
}
sub EVT_SPLITTER_DOUBLECLICKED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_SPLITTER_DOUBLECLICKED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_DOUBLECLICKED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# SysColourChangedEvent
#

sub EVT_SYS_COLOUR_CHANGED($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SYS_COLOUR_CHANGED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# Taskbar
#

sub EVT_TASKBAR_MOVE($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_MOVE, $_[1] ); 
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_TASKBAR_LEFT_DOWN($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_LEFT_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_TASKBAR_LEFT_UP($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_LEFT_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_TASKBAR_RIGHT_DOWN($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_RIGHT_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_TASKBAR_RIGHT_UP($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_RIGHT_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_TASKBAR_LEFT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_LEFT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}
sub EVT_TASKBAR_RIGHT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_RIGHT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            event       => $event,
         });
      });
   }
}

#
# TreeEvent
#

sub EVT_TREE_BEGIN_DRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_BEGIN_RDRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_RDRAG, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_RDRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_END_DRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_END_DRAG, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_END_DRAG, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_BEGIN_LABEL_EDIT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_END_LABEL_EDIT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_END_LABEL_EDIT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_END_LABEL_EDIT, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_GET_INFO($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_GET_INFO, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_GET_INFO, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_SET_INFO($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CLOSE_WINDOW, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SET_INFO, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_ITEM_EXPANDED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_ITEM_EXPANDED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_EXPANDED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_ITEM_EXPANDING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_ITEM_EXPANDING, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_EXPANDING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_ITEM_COLLAPSED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_ITEM_COLLAPSED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_COLLAPSED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_ITEM_COLLAPSING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_COLLAPSING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_COLLAPSING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_SEL_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SEL_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SEL_CHANGED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_SEL_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SEL_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SEL_CHANGING, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_KEY_DOWN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_KEY_DOWN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_KEY_DOWN, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_DELETE_ITEM($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_DELETE_ITEM, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_DELETE_ITEM, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_ITEM_ACTIVATED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_ACTIVATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_ACTIVATED, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_ITEM_RIGHT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_ITEM_MIDDLE_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_TREE_ITEM_MENU($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_MENU, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_MENU, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# UpdateUIEvent
#
sub EVT_UPDATE_UI($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::EVT_UPDATE_UI, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_UPDATE_UI, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}
sub EVT_UPDATE_UI_RANGE($$$$) { # FIX ME !!
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], $_[2], &Wx::EVT_UPDATE_UI_RANGE, $_[3] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::EVT_UPDATE_UI_RANGE, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# HyperlinkEvent
#
sub EVT_HYPERLINK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::EVT_HYPERLINK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_HYPERLINK, sub {
         my( $this, $event ) = @_;
   
         POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', {
            controller  => $controller,
            parent      => $parent,
            control     => $control,
            event       => $event,
         });
      });
   }
}

#
# Socket
#

sub EVT_SOCKET($$$) { goto &Wx::Socket::Event::EVT_SOCKET }
sub EVT_SOCKET_ALL($$$) { goto &Wx::Socket::Event::EVT_SOCKET_ALL }
sub EVT_SOCKET_INPUT($$$) { goto &Wx::Socket::Event::EVT_SOCKET_INPUT }
sub EVT_SOCKET_OUTPUT($$$) { goto &Wx::Socket::Event::EVT_SOCKET_OUTPUT }
sub EVT_SOCKET_CONNECTION($$$) { goto &Wx::Socket::Event::EVT_SOCKET_CONNECTION }
sub EVT_SOCKET_LOST($$$) { goto &Wx::Socket::Event::EVT_SOCKET_LOST }

#
# Prototypes
#
sub EVT_CALENDAR($$$);
sub EVT_CALENDAR_SEL_CHANGED($$$);
sub EVT_CALENDAR_DAY($$$);
sub EVT_CALENDAR_MONTH($$$);
sub EVT_CALENDAR_YEAR($$$);
sub EVT_CALENDAR_WEEKDAY_CLICKED($$$);

sub EVT_STC_CHANGE($$$);
sub EVT_STC_STYLENEEDED($$$);
sub EVT_STC_CHARADDED($$$);
sub EVT_STC_SAVEPOINTREACHED($$$);
sub EVT_STC_SAVEPOINTLEFT($$$);
sub EVT_STC_ROMODIFYATTEMPT($$$);
sub EVT_STC_KEY($$$);
sub EVT_STC_DOUBLECLICK($$$);
sub EVT_STC_UPDATEUI($$$);
sub EVT_STC_MODIFIED($$$);
sub EVT_STC_MACRORECORD($$$);
sub EVT_STC_MARGINCLICK($$$);
sub EVT_STC_NEEDSHOWN($$$);
sub EVT_STC_POSCHANGED($$$);
sub EVT_STC_PAINTED($$$);
sub EVT_STC_USERLISTSELECTION($$$);
sub EVT_STC_URIDROPPED($$$);
sub EVT_STC_DWELLSTART($$$);
sub EVT_STC_DWELLEND($$$);
sub EVT_STC_START_DRAG($$$);
sub EVT_STC_DRAG_OVER($$$);
sub EVT_STC_DO_DROP($$$);
sub EVT_STC_ZOOM($$$);
sub EVT_STC_HOTSPOT_CLICK($$$);
sub EVT_STC_HOTSPOT_DCLICK($$$);
sub EVT_STC_CALLTIP_CLICK($$$);

push @EXPORT_OK, qw(EVT
EVT_QUIT
EVT_ACTIVATE
EVT_ACTIVATE_APP
EVT_COMMAND_RANGE
EVT_BUTTON
EVT_CHECKBOX
EVT_CHOICE
EVT_LISTBOX
EVT_LISTBOX_DCLICK
EVT_TEXT
EVT_TEXT_ENTER
EVT_TEXT_MAXLEN
EVT_TEXT_URL
EVT_MENU
EVT_MENU_RANGE
EVT_SLIDER
EVT_RADIOBOX
EVT_RADIOBUTTON
EVT_SCROLLBAR
EVT_COMBOBOX
EVT_TOOL
EVT_TOOL_RANGE
EVT_TOOL_RCLICKED
EVT_TOOL_RCLICKED_RANGE
EVT_TOOL_ENTER
EVT_COMMAND_LEFT_CLICK
EVT_COMMAND_LEFT_DCLICK
EVT_COMMAND_RIGHT_CLICK
EVT_COMMAND_SET_FOCUS
EVT_COMMAND_KILL_FOCUS
EVT_COMMAND_ENTER
EVT_TOGGLEBUTTON
EVT_CHECKLISTBOX
EVT_TEXT_CUT
EVT_TEXT_COPY
EVT_TEXT_PASTE
EVT_CLOSE
EVT_END_SESSION
EVT_QUERY_END_SESSION
EVT_DROP_FILES
EVT_ERASE_BACKGROUND
EVT_FIND
EVT_FIND_NEXT
EVT_FIND_REPLACE
EVT_FIND_REPLACE_ALL
EVT_FIND_CLOSE
EVT_SET_FOCUS
EVT_KILL_FOCUS
EVT_CHAR
EVT_CHAR_HOOK
EVT_KEY_DOWN
EVT_KEY_UP
EVT_GRID_CELL_LEFT_CLICK
EVT_GRID_CELL_RIGHT_CLICK
EVT_GRID_CELL_LEFT_DCLICK
EVT_GRID_CELL_RIGHT_DCLICK
EVT_GRID_LABEL_LEFT_CLICK
EVT_GRID_LABEL_RIGHT_CLICK
EVT_GRID_LABEL_LEFT_DCLICK
EVT_GRID_LABEL_RIGHT_DCLICK
EVT_GRID_ROW_SIZE
EVT_GRID_COL_SIZE
EVT_GRID_RANGE_SELECT
EVT_GRID_CELL_CHANGE
EVT_GRID_SELECT_CELL
EVT_GRID_EDITOR_SHOWN
EVT_GRID_EDITOR_HIDDEN
EVT_GRID_EDITOR_CREATED
EVT_HELP
EVT_HELP_RANGE
EVT_DETAILED_HELP
EVT_DETAILED_HELP_RANGE
EVT_ICONIZE
EVT_IDLE
EVT_INIT_DIALOG
EVT_JOY_BUTTON_DOWN
EVT_JOY_BUTTON_UP
EVT_JOY_MOVE
EVT_JOY_ZMOVE
EVT_LISTBOOK_PAGE_CHANGING
EVT_LISTBOOK_PAGE_CHANGED
EVT_CHOICEBOOK_PAGE_CHANGING
EVT_CHOICEBOOK_PAGE_CHANGED
EVT_TOOLBOOK_PAGE_CHANGING
EVT_TOOLBOOK_PAGE_CHANGED
EVT_TREEBOOK_PAGE_CHANGING
EVT_TREEBOOK_PAGE_CHANGED
EVT_TREEBOOK_NODE_COLLAPSED
EVT_TREEBOOK_NODE_EXPANDED
EVT_LIST_BEGIN_DRAG
EVT_LIST_BEGIN_RDRAG
EVT_LIST_BEGIN_LABEL_EDIT
EVT_LIST_CACHE_HINT
EVT_LIST_END_LABEL_EDIT
EVT_LIST_DELETE_ITEM
EVT_LIST_DELETE_ALL_ITEMS
EVT_LIST_GET_INFO
EVT_LIST_SET_INFO
EVT_LIST_ITEM_SELECTED
EVT_LIST_ITEM_DESELECTED
EVT_LIST_KEY_DOWN
EVT_LIST_INSERT_ITEM
EVT_LIST_COL_CLICK
EVT_LIST_RIGHT_CLICK
EVT_LIST_MIDDLE_CLICK
EVT_LIST_ITEM_ACTIVATED
EVT_LIST_COL_RIGHT_CLICK
EVT_LIST_COL_BEGIN_DRAG
EVT_LIST_COL_DRAGGING
EVT_LIST_COL_END_DRAG
EVT_LIST_ITEM_FOCUSED
EVT_LIST_ITEM_RIGHT_CLICK
EVT_MENU_CHAR
EVT_MENU_INIT
EVT_MENU_HIGHLIGHT
EVT_POPUP_MENU
EVT_CONTEXT_MENU
EVT_MENU_OPEN
EVT_MENU_CLOSE
EVT_LEFT_DOWN
EVT_LEFT_UP
EVT_LEFT_DCLICK
EVT_MIDDLE_DOWN
EVT_MIDDLE_UP
EVT_MIDDLE_DCLICK
EVT_RIGHT_DOWN
EVT_RIGHT_UP
EVT_RIGHT_DCLICK
EVT_MOTION
EVT_ENTER_WINDOW
EVT_LEAVE_WINDOW
EVT_MOUSEWHEEL
EVT_MOUSE_EVENTS
EVT_MOVE
EVT_MOVING
EVT_NOTEBOOK_PAGE_CHANGING
EVT_NOTEBOOK_PAGE_CHANGED
EVT_PAINT
EVT_END_PROCESS
EVT_SASH_DRAGGED
EVT_SASH_DRAGGED_RANGE
EVT_SIZE
EVT_SIZING
EVT_SCROLL_TOP
EVT_SCROLL_BOTTOM
EVT_SCROLL_LINEUP
EVT_SCROLL_LINEDOWN
EVT_SCROLL_PAGEUP
EVT_SCROLL_PAGEDOWN
EVT_SCROLL_THUMBTRACK
EVT_SCROLL_THUMBRELEASE
EVT_COMMAND_SCROLL_TOP
EVT_COMMAND_SCROLL_BOTTOM
EVT_COMMAND_SCROLL_LINEUP
EVT_COMMAND_SCROLL_LINEDOWN
EVT_COMMAND_SCROLL_PAGEUP
EVT_COMMAND_SCROLL_PAGEDOWN
EVT_COMMAND_SCROLL_THUMBTRACK
EVT_COMMAND_SCROLL_THUMBRELEASE
EVT_SCROLLWIN_TOP
EVT_SCROLLWIN_BOTTOM
EVT_SCROLLWIN_LINEUP
EVT_SCROLLWIN_LINEDOWN
EVT_SCROLLWIN_PAGEUP
EVT_SCROLLWIN_PAGEDOWN
EVT_SCROLLWIN_THUMBTRACK
EVT_SCROLLWIN_THUMBRELEASE
EVT_SPIN_UP
EVT_SPIN_DOWN
EVT_SPIN
EVT_SPINCTRL
EVT_SPLITTER_SASH_POS_CHANGING
EVT_SPLITTER_SASH_POS_CHANGED
EVT_SPLITTER_UNSPLIT
EVT_SPLITTER_DOUBLECLICKED
EVT_SYS_COLOUR_CHANGED
EVT_TASKBAR_MOVE
EVT_TASKBAR_LEFT_DOWN
EVT_TASKBAR_LEFT_UP
EVT_TASKBAR_RIGHT_DOWN
EVT_TASKBAR_RIGHT_UP
EVT_TASKBAR_LEFT_DCLICK
EVT_TASKBAR_RIGHT_DCLICK
EVT_TREE_BEGIN_DRAG
EVT_TREE_BEGIN_RDRAG
EVT_TREE_END_DRAG
EVT_TREE_BEGIN_LABEL_EDIT
EVT_TREE_END_LABEL_EDIT
EVT_TREE_GET_INFO
EVT_TREE_SET_INFO
EVT_TREE_ITEM_EXPANDED
EVT_TREE_ITEM_EXPANDING
EVT_TREE_ITEM_COLLAPSED
EVT_TREE_ITEM_COLLAPSING
EVT_TREE_SEL_CHANGED
EVT_TREE_SEL_CHANGING
EVT_TREE_KEY_DOWN
EVT_TREE_DELETE_ITEM
EVT_TREE_ITEM_ACTIVATED
EVT_TREE_ITEM_RIGHT_CLICK
EVT_TREE_ITEM_MIDDLE_CLICK
EVT_TREE_ITEM_MENU
EVT_UPDATE_UI
EVT_UPDATE_UI_RANGE
EVT_HYPERLINK
EVT_SOCKET
EVT_SOCKET_ALL
EVT_SOCKET_INPUT
EVT_SOCKET_OUTPUT
EVT_SOCKET_CONNECTION
EVT_SOCKET_LOST
EVT_CALENDAR
EVT_CALENDAR_SEL_CHANGED
EVT_CALENDAR_DAY
EVT_CALENDAR_MONTH
EVT_CALENDAR_YEAR
EVT_CALENDAR_WEEKDAY_CLICKED
EVT_STC_CHANGE
EVT_STC_STYLENEEDED
EVT_STC_CHARADDED
EVT_STC_SAVEPOINTREACHED
EVT_STC_SAVEPOINTLEFT
EVT_STC_ROMODIFYATTEMPT
EVT_STC_KEY
EVT_STC_DOUBLECLICK
EVT_STC_UPDATEUI
EVT_STC_MODIFIED
EVT_STC_MACRORECORD
EVT_STC_MARGINCLICK
EVT_STC_NEEDSHOWN
EVT_STC_POSCHANGED
EVT_STC_PAINTED
EVT_STC_USERLISTSELECTION
EVT_STC_URIDROPPED
EVT_STC_DWELLSTART
EVT_STC_DWELLEND
EVT_STC_START_DRAG
EVT_STC_DRAG_OVER
EVT_STC_DO_DROP
EVT_STC_ZOOM
EVT_STC_HOTSPOT_CLICK
EVT_STC_HOTSPOT_DCLICK
EVT_STC_CALLTIP_CLICK);

1;

__END__

# local variables:
# mode: cperl
# end:
