package Catalyst::Engine::Wx::Event;

use strict;
use vars qw(@ISA @EXPORT_OK);

our $VERSION = "0.02_05";

use Exporter;

@ISA = qw(Exporter);

# We have exceptions to the classical GetValue
# and we deal with these with a hash table
# Until now most stuff should be ok with GetValue
# and GetStringSelection
my $getValue = {};

#$getValue->{'Wx::TextCtrl'} = sub {
#    return $_[0]->GetValue;
#};

sub _post_event {
    my ($opt) = @_;
    
    if (defined $opt->{parent} && $opt->{parent}->can('GetChildren')) {
        foreach ($opt->{parent}->GetChildren) {
            if ($_->can('GetValue')) {
                $opt->{$_->GetName} = $_->GetValue;
            }
            elsif ($_->can('GetStringSelection')) {
                $opt->{$_->GetName} = $_->GetStringSelection;
            }
            elsif ( $getValue->{ ref($_) } ) {
                $opt->{$_->GetName} = $getValue->{ ref($_) }($_);
            }
        }
    }
    
    POE::Kernel->post('catalyst-wxperl', 'EVENT_REQUEST', $opt);
}


  
sub CAT_EVT_QUIT { 
   POE::Kernel->post('catalyst-wxperl', '_stop');
}

sub CAT_EVT {
    my $parent     = $_[0];
    my $controller = $_[1];
    my $params     = $_[2] || {};
    
    $params->{'controller'} = $controller;
    $params->{'parent'}     = $parent;
    
    _post_event($params);
}

#
# ActivateEvent
#

sub CAT_EVT_ACTIVATE($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE, sub {
         my( $this, $event ) = @_;
         _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
         });
      });
   }
}
sub CAT_EVT_ACTIVATE_APP($$) {  
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE_APP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE_APP, sub {
         my( $this, $event ) = @_;
         _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
         });
      });
   }
}

#
# CommandEvent
#
sub CAT_EVT_COMMAND_RANGE($$$$$) { $_[0]->Connect( $_[1], $_[2], $_[3], $_[4] ) } # FIX ME !!

sub CAT_EVT_BUTTON {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_BUTTON_CLICKED, $_[2] );
   }
   else {      
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_BUTTON_CLICKED, sub { 
            my( $this, $event ) = @_;
            _post_event({
                controller  => $controller,
                parent      => $parent,
                control     => $this,
                event       => $event
            });
       });
   }
}
sub CAT_EVT_CHECKBOX($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHECKBOX_CLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHECKBOX_CLICKED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_CHOICE($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICE_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICE_SELECTED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_LISTBOX($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOX_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOX_SELECTED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LISTBOX_DCLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_TEXT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_UPDATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_UPDATED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
# ------------------------------------------------------------------------------------------------------
sub CAT_EVT_TEXT_ENTER($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_ENTER, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_ENTER, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_TEXT_MAXLEN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_MAXLEN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_MAXLEN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_TEXT_URL($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_URL, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_URL, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_MENU($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_MENU_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_MENU_SELECTED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
# NEEDS FIX !!
sub CAT_EVT_MENU_RANGE($$$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_MENU_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_MENU_SELECTED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_SLIDER($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SLIDER_UPDATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SLIDER_UPDATED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_RADIOBOX($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RADIOBOX_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RADIOBOX_SELECTED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_RADIOBUTTON($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RADIOBUTTON_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RADIOBUTTON_SELECTED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_SCROLLBAR($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SCROLLBAR_UPDATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SCROLLBAR_UPDATED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_COMBOBOX($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_COMBOBOX_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_COMBOBOX_SELECTED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_TOOL($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_CLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_CLICKED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
# NEEDS FIX !!
sub CAT_EVT_TOOL_RANGE($$$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_CLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_CLICKED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_TOOL_RCLICKED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_RCLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_RCLICKED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
# NEEDS FIX !!
sub CAT_EVT_TOOL_RCLICKED_RANGE($$$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_RCLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_RCLICKED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_TOOL_ENTER($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_ENTER, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_ENTER, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_COMMAND_LEFT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LEFT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LEFT_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_COMMAND_LEFT_DCLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LEFT_DCLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LEFT_DCLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_COMMAND_RIGHT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RIGHT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_COMMAND_SET_FOCUS($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SET_FOCUS, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SET_FOCUS, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_COMMAND_KILL_FOCUS($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_KILL_FOCUS, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_KILL_FOCUS, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_COMMAND_ENTER($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_ENTER, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_ENTER, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_TOGGLEBUTTON($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_CHECKLISTBOX($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHECKLISTBOX_TOGGLED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHECKLISTBOX_TOGGLED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   } 
}
sub CAT_EVT_TEXT_CUT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_CUT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_CUT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_TEXT_COPY($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_COPY, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_COPY, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}
sub CAT_EVT_TEXT_PASTE($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_PASTE, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_PASTE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      }); 
   }
}

#
# CloseEvent
#
sub CAT_EVT_CLOSE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CLOSE_WINDOW, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CLOSE_WINDOW, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });  
   }
}
sub CAT_EVT_END_SESSION($$) {
   if (ref $_[1] eq 'CODE') { 
      $_[0]->Connect( -1, -1, &Wx::wxEVT_END_SESSION, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_END_SESSION, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });  
   }
}
sub CAT_EVT_QUERY_END_SESSION($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_QUERY_END_SESSION, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_QUERY_END_SESSION, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });  
   }
}

#
# DropFilesEvent
#

sub CAT_EVT_DROP_FILES($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_DROP_FILES, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_DROP_FILES, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });  
   }
}

#
# EraseEvent
#
sub CAT_EVT_ERASE_BACKGROUND($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ERASE_BACKGROUND, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ERASE_BACKGROUND, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });  
   }
}

#
# FindDialogEvent
#
sub CAT_EVT_FIND($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_FIND_NEXT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_NEXT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_NEXT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_FIND_REPLACE($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_REPLACE, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_REPLACE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_FIND_REPLACE_ALL($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_REPLACE_ALL, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_REPLACE_ALL, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_FIND_CLOSE($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_CLOSE, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_CLOSE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# FocusEvent
#
sub CAT_EVT_SET_FOCUS($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SET_FOCUS, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SET_FOCUS, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_KILL_FOCUS($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KILL_FOCUS, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KILL_FOCUS, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# KeyEvent
#

sub CAT_EVT_CHAR($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CHAR, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CHAR, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_CHAR_HOOK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CHAR_HOOK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CHAR_HOOK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_KEY_DOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KEY_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KEY_DOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_KEY_UP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KEY_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_KEY_UP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# Grid*Event
#

sub CAT_EVT_GRID_CELL_LEFT_CLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_LEFT_CLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_LEFT_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_CELL_RIGHT_CLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_RIGHT_CLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_CELL_LEFT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_LEFT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_LEFT_DCLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_CELL_RIGHT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_RIGHT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_RIGHT_DCLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_LABEL_LEFT_CLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_LEFT_CLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_LEFT_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_LABEL_RIGHT_CLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_RIGHT_CLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_LABEL_LEFT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_LEFT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_LEFT_DCLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_LABEL_RIGHT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_RIGHT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_RIGHT_DCLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_ROW_SIZE($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_ROW_SIZE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_ROW_SIZE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_COL_SIZE($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_COL_SIZE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_COL_SIZE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_RANGE_SELECT($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_RANGE_SELECT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_RANGE_SELECT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_CELL_CHANGE($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_CHANGE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_CHANGE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_SELECT_CELL($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_SELECT_CELL, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_SELECT_CELL, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_EDITOR_SHOWN($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_SHOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_SHOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_EDITOR_HIDDEN($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_HIDDEN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_HIDDEN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_GRID_EDITOR_CREATED($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_CREATED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_CREATED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# HelpEvent
#

sub CAT_EVT_HELP($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_HELP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_HELP_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_HELP, $_[3] ) } # FIX ME !!!!
sub CAT_EVT_DETAILED_HELP($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_DETAILED_HELP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_DETAILED_HELP_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_DETAILED_HELP, $_[3] ) } # FIX ME !!!!

#
# IconizeEvent
#

sub CAT_EVT_ICONIZE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ICONIZE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ICONIZE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# IdleEvent
#

sub CAT_EVT_IDLE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_IDLE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_IDLE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# InitDialogEvent
#

sub CAT_EVT_INIT_DIALOG($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_INIT_DIALOG, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_INIT_DIALOG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# JoystickEvent
#

sub CAT_EVT_JOY_BUTTON_DOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_BUTTON_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_BUTTON_DOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_JOY_BUTTON_UP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_BUTTON_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_BUTTON_UP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_JOY_MOVE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_MOVE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_MOVE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_JOY_ZMOVE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_ZMOVE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller  = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_ZMOVE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# ListbookEvent
#

sub CAT_EVT_LISTBOOK_PAGE_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LISTBOOK_PAGE_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# ChoicebookEvent
#

sub CAT_EVT_CHOICEBOOK_PAGE_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_CHOICEBOOK_PAGE_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# ToolbookEvent
#

sub CAT_EVT_TOOLBOOK_PAGE_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TOOLBOOK_PAGE_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# TreebookEvent
#
sub CAT_EVT_TREEBOOK_PAGE_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREEBOOK_PAGE_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREEBOOK_NODE_COLLAPSED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREEBOOK_NODE_EXPANDED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# ListEvent
#
sub CAT_EVT_LIST_BEGIN_DRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_DRAG, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_BEGIN_RDRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_RDRAG, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_RDRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_BEGIN_LABEL_EDIT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_CACHE_HINT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_CACHE_HINT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_CACHE_HINT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_END_LABEL_EDIT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_END_LABEL_EDIT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_END_LABEL_EDIT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_DELETE_ITEM($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_DELETE_ITEM, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_DELETE_ITEM, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_DELETE_ALL_ITEMS($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_GET_INFO($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_GET_INFO, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_GET_INFO, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_SET_INFO($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_SET_INFO, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_SET_INFO, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_ITEM_SELECTED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_SELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_SELECTED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_ITEM_DESELECTED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_DESELECTED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_DESELECTED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_KEY_DOWN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_KEY_DOWN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_KEY_DOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_INSERT_ITEM($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_INSERT_ITEM, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_INSERT_ITEM, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_COL_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_RIGHT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_RIGHT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_MIDDLE_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_MIDDLE_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_MIDDLE_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_ITEM_ACTIVATED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_ACTIVATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_ACTIVATED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_COL_RIGHT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_RIGHT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_COL_BEGIN_DRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_BEGIN_DRAG, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_COL_DRAGGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_DRAGGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_DRAGGING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_COL_END_DRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_END_DRAG, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_END_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_ITEM_FOCUSED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_FOCUSED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_FOCUSED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LIST_ITEM_RIGHT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# MenuEvent
#

sub CAT_EVT_MENU_CHAR($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CHAR, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CHAR, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MENU_INIT($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_INIT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_INIT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MENU_HIGHLIGHT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_MENU_HIGHLIGHT, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_MENU_HIGHLIGHT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_POPUP_MENU($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_POPUP_MENU, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_POPUP_MENU, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_CONTEXT_MENU($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CONTEXT_MENU, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CONTEXT_MENU, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MENU_OPEN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_OPEN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_OPEN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MENU_CLOSE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CLOSE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CLOSE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# MouseEvent
#
sub CAT_EVT_LEFT_DOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_DOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LEFT_UP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_UP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LEFT_DCLICK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_DCLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MIDDLE_DOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_DOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MIDDLE_UP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_UP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MIDDLE_DCLICK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_DCLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_RIGHT_DOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_DOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_RIGHT_UP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_UP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_RIGHT_DCLICK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_DCLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MOTION($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOTION, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOTION, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_ENTER_WINDOW($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ENTER_WINDOW, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_ENTER_WINDOW, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_LEAVE_WINDOW($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEAVE_WINDOW, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_LEAVE_WINDOW, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MOUSEWHEEL($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOUSEWHEEL, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOUSEWHEEL, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MOUSE_EVENTS($$) {
  my( $x, $y ) = @_;
  CAT_EVT_LEFT_DOWN( $x, $y );
  CAT_EVT_LEFT_UP( $x, $y );
  CAT_EVT_LEFT_DCLICK( $x, $y );
  CAT_EVT_MIDDLE_DOWN( $x, $y );
  CAT_EVT_MIDDLE_UP( $x, $y );
  CAT_EVT_MIDDLE_DCLICK( $x, $y );
  CAT_EVT_RIGHT_DOWN( $x, $y );
  CAT_EVT_RIGHT_UP( $x, $y );
  CAT_EVT_RIGHT_DCLICK( $x, $y );
  CAT_EVT_MOTION( $x, $y );
  CAT_EVT_ENTER_WINDOW( $x, $y );
  CAT_EVT_LEAVE_WINDOW( $x, $y );
  CAT_EVT_MOUSEWHEEL( $x, $y );
}

#
# MoveEvent
#

sub CAT_EVT_MOVE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOVE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOVE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_MOVING($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOVING, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_MOVING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# NotebookEvent
#

sub CAT_EVT_NOTEBOOK_PAGE_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_NOTEBOOK_PAGE_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# PaintEvent
#

sub CAT_EVT_PAINT($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_PAINT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_PAINT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# ProcessEvent
#

sub CAT_EVT_END_PROCESS($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_END_PROCESS, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_END_PROCESS, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# SashEvent
#
sub CAT_EVT_SASH_DRAGGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SASH_DRAGGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SASH_DRAGGED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SASH_DRAGGED_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_SASH_DRAGGED, $_[3] ) }

#
# SizeEvent
#

sub CAT_EVT_SIZE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SIZE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SIZING($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SIZING, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# ScrollEvent
#

sub CAT_EVT_SCROLL_TOP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLL_BOTTOM($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_BOTTOM, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLL_LINEUP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_LINEUP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLL_LINEDOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_LINEDOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLL_PAGEUP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_PAGEUP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLL_PAGEDOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_PAGEDOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLL_THUMBTRACK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_THUMBTRACK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLL_THUMBRELEASE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_THUMBRELEASE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

sub CAT_EVT_COMMAND_SCROLL_TOP($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_TOP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_TOP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_COMMAND_SCROLL_BOTTOM($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_BOTTOM, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_BOTTOM, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_COMMAND_SCROLL_LINEUP($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_COMMAND_SCROLL_LINEDOWN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEDOWN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEDOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   } 
}
sub CAT_EVT_COMMAND_SCROLL_PAGEUP($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEUP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_COMMAND_SCROLL_PAGEDOWN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEDOWN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEDOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_COMMAND_SCROLL_THUMBTRACK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBTRACK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBTRACK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_COMMAND_SCROLL_THUMBRELEASE($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBRELEASE, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBRELEASE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# ScrollWinEvent
#
sub CAT_EVT_SCROLLWIN_TOP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_TOP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLLWIN_BOTTOM($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_BOTTOM, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLLWIN_LINEUP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_LINEUP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLLWIN_LINEDOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_LINEDOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLLWIN_PAGEUP($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_PAGEUP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLLWIN_PAGEDOWN($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_PAGEDOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLLWIN_THUMBTRACK($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_THUMBTRACK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SCROLLWIN_THUMBRELEASE($$) {
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_THUMBRELEASE, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# SpinEvent
#

sub CAT_EVT_SPIN_UP($$$) { 
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SPIN_DOWN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEDOWN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEDOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SPIN($$$) { 
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBTRACK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBTRACK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SPINCTRL($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPINCTRL_UPDATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPINCTRL_UPDATED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# SplitterEvent
#
sub CAT_EVT_SPLITTER_SASH_POS_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SPLITTER_SASH_POS_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_SPLITTER_UNSPLIT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_SPLITTER_UNSPLIT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_UNSPLIT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   } 
}
sub CAT_EVT_SPLITTER_DOUBLECLICKED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_SPLITTER_DOUBLECLICKED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_DOUBLECLICKED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# SysColourChangedEvent
#

sub CAT_EVT_SYS_COLOUR_CHANGED($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_SYS_COLOUR_CHANGED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# Taskbar
#

sub CAT_EVT_TASKBAR_MOVE($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_MOVE, $_[1] ); 
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TASKBAR_LEFT_DOWN($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_LEFT_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TASKBAR_LEFT_UP($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_LEFT_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TASKBAR_RIGHT_DOWN($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_RIGHT_DOWN, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TASKBAR_RIGHT_UP($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_RIGHT_UP, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TASKBAR_LEFT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_LEFT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TASKBAR_RIGHT_DCLICK($$) { 
   if (ref $_[1] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_RIGHT_DCLICK, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $controller = $_[1];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# TreeEvent
#

sub CAT_EVT_TREE_BEGIN_DRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_BEGIN_RDRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_RDRAG, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_RDRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_END_DRAG($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_END_DRAG, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_END_DRAG, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_BEGIN_LABEL_EDIT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_END_LABEL_EDIT($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_END_LABEL_EDIT, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_END_LABEL_EDIT, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_GET_INFO($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_GET_INFO, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_GET_INFO, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_SET_INFO($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_CLOSE_WINDOW, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SET_INFO, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_ITEM_EXPANDED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_ITEM_EXPANDED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_EXPANDED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_ITEM_EXPANDING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_ITEM_EXPANDING, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_EXPANDING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_ITEM_COLLAPSED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( -1, -1, &Wx::wxEVT_COMMAND_TREE_ITEM_COLLAPSED, $_[1] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_COLLAPSED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_ITEM_COLLAPSING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_COLLAPSING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_COLLAPSING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_SEL_CHANGED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SEL_CHANGED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SEL_CHANGED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_SEL_CHANGING($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SEL_CHANGING, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SEL_CHANGING, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_KEY_DOWN($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_KEY_DOWN, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_KEY_DOWN, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_DELETE_ITEM($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_DELETE_ITEM, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_DELETE_ITEM, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_ITEM_ACTIVATED($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_ACTIVATED, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_ACTIVATED, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_ITEM_RIGHT_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_ITEM_MIDDLE_CLICK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_TREE_ITEM_MENU($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_MENU, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_MENU, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# UpdateUIEvent
#
sub CAT_EVT_UPDATE_UI($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::CAT_EVT_UPDATE_UI, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_UPDATE_UI, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}
sub CAT_EVT_UPDATE_UI_RANGE($$$$) { # FIX ME !!
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], $_[2], &Wx::CAT_EVT_UPDATE_UI_RANGE, $_[3] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::CAT_EVT_UPDATE_UI_RANGE, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# HyperlinkEvent
#
sub CAT_EVT_HYPERLINK($$$) {
   if (ref $_[2] eq 'CODE') {
      $_[0]->Connect( $_[1], -1, &Wx::CAT_EVT_HYPERLINK, $_[2] );
   }
   else {
      my $parent     = $_[0];
      my $control    = $_[1];
      my $controller = $_[2];
      
      $_[0]->Connect( $_[1], -1, &Wx::wxEVT_HYPERLINK, sub {
         my( $this, $event ) = @_;
        _post_event({
            controller  => $controller,
            parent      => $parent,
            control     => $this,
            event       => $event
        });
      });
   }
}

#
# Socket
#

sub CAT_EVT_SOCKET($$$) { goto &Wx::Socket::Event::CAT_EVT_SOCKET }
sub CAT_EVT_SOCKET_ALL($$$) { goto &Wx::Socket::Event::CAT_EVT_SOCKET_ALL }
sub CAT_EVT_SOCKET_INPUT($$$) { goto &Wx::Socket::Event::CAT_EVT_SOCKET_INPUT }
sub CAT_EVT_SOCKET_OUTPUT($$$) { goto &Wx::Socket::Event::CAT_EVT_SOCKET_OUTPUT }
sub CAT_EVT_SOCKET_CONNECTION($$$) { goto &Wx::Socket::Event::CAT_EVT_SOCKET_CONNECTION }
sub CAT_EVT_SOCKET_LOST($$$) { goto &Wx::Socket::Event::CAT_EVT_SOCKET_LOST }

#
# Prototypes
#
sub CAT_EVT_CALENDAR($$$);
sub CAT_EVT_CALENDAR_SEL_CHANGED($$$);
sub CAT_EVT_CALENDAR_DAY($$$);
sub CAT_EVT_CALENDAR_MONTH($$$);
sub CAT_EVT_CALENDAR_YEAR($$$);
sub CAT_EVT_CALENDAR_WEEKDAY_CLICKED($$$);

sub CAT_EVT_STC_CHANGE($$$);
sub CAT_EVT_STC_STYLENEEDED($$$);
sub CAT_EVT_STC_CHARADDED($$$);
sub CAT_EVT_STC_SAVEPOINTREACHED($$$);
sub CAT_EVT_STC_SAVEPOINTLEFT($$$);
sub CAT_EVT_STC_ROMODIFYATTEMPT($$$);
sub CAT_EVT_STC_KEY($$$);
sub CAT_EVT_STC_DOUBLECLICK($$$);
sub CAT_EVT_STC_UPDATEUI($$$);
sub CAT_EVT_STC_MODIFIED($$$);
sub CAT_EVT_STC_MACRORECORD($$$);
sub CAT_EVT_STC_MARGINCLICK($$$);
sub CAT_EVT_STC_NEEDSHOWN($$$);
sub CAT_EVT_STC_POSCHANGED($$$);
sub CAT_EVT_STC_PAINTED($$$);
sub CAT_EVT_STC_USERLISTSELECTION($$$);
sub CAT_EVT_STC_URIDROPPED($$$);
sub CAT_EVT_STC_DWELLSTART($$$);
sub CAT_EVT_STC_DWELLEND($$$);
sub CAT_EVT_STC_START_DRAG($$$);
sub CAT_EVT_STC_DRAG_OVER($$$);
sub CAT_EVT_STC_DO_DROP($$$);
sub CAT_EVT_STC_ZOOM($$$);
sub CAT_EVT_STC_HOTSPOT_CLICK($$$);
sub CAT_EVT_STC_HOTSPOT_DCLICK($$$);
sub CAT_EVT_STC_CALLTIP_CLICK($$$);

push @EXPORT_OK, qw(
CAT_EVT
CAT_EVT_QUIT
CAT_EVT_ACTIVATE
CAT_EVT_ACTIVATE_APP
CAT_EVT_COMMAND_RANGE
CAT_EVT_BUTTON
CAT_EVT_CHECKBOX
CAT_EVT_CHOICE
CAT_EVT_LISTBOX
CAT_EVT_LISTBOX_DCLICK
CAT_EVT_TEXT
CAT_EVT_TEXT_ENTER
CAT_EVT_TEXT_MAXLEN
CAT_EVT_TEXT_URL
CAT_EVT_MENU
CAT_EVT_MENU_RANGE
CAT_EVT_SLIDER
CAT_EVT_RADIOBOX
CAT_EVT_RADIOBUTTON
CAT_EVT_SCROLLBAR
CAT_EVT_COMBOBOX
CAT_EVT_TOOL
CAT_EVT_TOOL_RANGE
CAT_EVT_TOOL_RCLICKED
CAT_EVT_TOOL_RCLICKED_RANGE
CAT_EVT_TOOL_ENTER
CAT_EVT_COMMAND_LEFT_CLICK
CAT_EVT_COMMAND_LEFT_DCLICK
CAT_EVT_COMMAND_RIGHT_CLICK
CAT_EVT_COMMAND_SET_FOCUS
CAT_EVT_COMMAND_KILL_FOCUS
CAT_EVT_COMMAND_ENTER
CAT_EVT_TOGGLEBUTTON
CAT_EVT_CHECKLISTBOX
CAT_EVT_TEXT_CUT
CAT_EVT_TEXT_COPY
CAT_EVT_TEXT_PASTE
CAT_EVT_CLOSE
CAT_EVT_END_SESSION
CAT_EVT_QUERY_END_SESSION
CAT_EVT_DROP_FILES
CAT_EVT_ERASE_BACKGROUND
CAT_EVT_FIND
CAT_EVT_FIND_NEXT
CAT_EVT_FIND_REPLACE
CAT_EVT_FIND_REPLACE_ALL
CAT_EVT_FIND_CLOSE
CAT_EVT_SET_FOCUS
CAT_EVT_KILL_FOCUS
CAT_EVT_CHAR
CAT_EVT_CHAR_HOOK
CAT_EVT_KEY_DOWN
CAT_EVT_KEY_UP
CAT_EVT_GRID_CELL_LEFT_CLICK
CAT_EVT_GRID_CELL_RIGHT_CLICK
CAT_EVT_GRID_CELL_LEFT_DCLICK
CAT_EVT_GRID_CELL_RIGHT_DCLICK
CAT_EVT_GRID_LABEL_LEFT_CLICK
CAT_EVT_GRID_LABEL_RIGHT_CLICK
CAT_EVT_GRID_LABEL_LEFT_DCLICK
CAT_EVT_GRID_LABEL_RIGHT_DCLICK
CAT_EVT_GRID_ROW_SIZE
CAT_EVT_GRID_COL_SIZE
CAT_EVT_GRID_RANGE_SELECT
CAT_EVT_GRID_CELL_CHANGE
CAT_EVT_GRID_SELECT_CELL
CAT_EVT_GRID_EDITOR_SHOWN
CAT_EVT_GRID_EDITOR_HIDDEN
CAT_EVT_GRID_EDITOR_CREATED
CAT_EVT_HELP
CAT_EVT_HELP_RANGE
CAT_EVT_DETAILED_HELP
CAT_EVT_DETAILED_HELP_RANGE
CAT_EVT_ICONIZE
CAT_EVT_IDLE
CAT_EVT_INIT_DIALOG
CAT_EVT_JOY_BUTTON_DOWN
CAT_EVT_JOY_BUTTON_UP
CAT_EVT_JOY_MOVE
CAT_EVT_JOY_ZMOVE
CAT_EVT_LISTBOOK_PAGE_CHANGING
CAT_EVT_LISTBOOK_PAGE_CHANGED
CAT_EVT_CHOICEBOOK_PAGE_CHANGING
CAT_EVT_CHOICEBOOK_PAGE_CHANGED
CAT_EVT_TOOLBOOK_PAGE_CHANGING
CAT_EVT_TOOLBOOK_PAGE_CHANGED
CAT_EVT_TREEBOOK_PAGE_CHANGING
CAT_EVT_TREEBOOK_PAGE_CHANGED
CAT_EVT_TREEBOOK_NODE_COLLAPSED
CAT_EVT_TREEBOOK_NODE_EXPANDED
CAT_EVT_LIST_BEGIN_DRAG
CAT_EVT_LIST_BEGIN_RDRAG
CAT_EVT_LIST_BEGIN_LABEL_EDIT
CAT_EVT_LIST_CACHE_HINT
CAT_EVT_LIST_END_LABEL_EDIT
CAT_EVT_LIST_DELETE_ITEM
CAT_EVT_LIST_DELETE_ALL_ITEMS
CAT_EVT_LIST_GET_INFO
CAT_EVT_LIST_SET_INFO
CAT_EVT_LIST_ITEM_SELECTED
CAT_EVT_LIST_ITEM_DESELECTED
CAT_EVT_LIST_KEY_DOWN
CAT_EVT_LIST_INSERT_ITEM
CAT_EVT_LIST_COL_CLICK
CAT_EVT_LIST_RIGHT_CLICK
CAT_EVT_LIST_MIDDLE_CLICK
CAT_EVT_LIST_ITEM_ACTIVATED
CAT_EVT_LIST_COL_RIGHT_CLICK
CAT_EVT_LIST_COL_BEGIN_DRAG
CAT_EVT_LIST_COL_DRAGGING
CAT_EVT_LIST_COL_END_DRAG
CAT_EVT_LIST_ITEM_FOCUSED
CAT_EVT_LIST_ITEM_RIGHT_CLICK
CAT_EVT_MENU_CHAR
CAT_EVT_MENU_INIT
CAT_EVT_MENU_HIGHLIGHT
CAT_EVT_POPUP_MENU
CAT_EVT_CONTEXT_MENU
CAT_EVT_MENU_OPEN
CAT_EVT_MENU_CLOSE
CAT_EVT_LEFT_DOWN
CAT_EVT_LEFT_UP
CAT_EVT_LEFT_DCLICK
CAT_EVT_MIDDLE_DOWN
CAT_EVT_MIDDLE_UP
CAT_EVT_MIDDLE_DCLICK
CAT_EVT_RIGHT_DOWN
CAT_EVT_RIGHT_UP
CAT_EVT_RIGHT_DCLICK
CAT_EVT_MOTION
CAT_EVT_ENTER_WINDOW
CAT_EVT_LEAVE_WINDOW
CAT_EVT_MOUSEWHEEL
CAT_EVT_MOUSE_EVENTS
CAT_EVT_MOVE
CAT_EVT_MOVING
CAT_EVT_NOTEBOOK_PAGE_CHANGING
CAT_EVT_NOTEBOOK_PAGE_CHANGED
CAT_EVT_PAINT
CAT_EVT_END_PROCESS
CAT_EVT_SASH_DRAGGED
CAT_EVT_SASH_DRAGGED_RANGE
CAT_EVT_SIZE
CAT_EVT_SIZING
CAT_EVT_SCROLL_TOP
CAT_EVT_SCROLL_BOTTOM
CAT_EVT_SCROLL_LINEUP
CAT_EVT_SCROLL_LINEDOWN
CAT_EVT_SCROLL_PAGEUP
CAT_EVT_SCROLL_PAGEDOWN
CAT_EVT_SCROLL_THUMBTRACK
CAT_EVT_SCROLL_THUMBRELEASE
CAT_EVT_COMMAND_SCROLL_TOP
CAT_EVT_COMMAND_SCROLL_BOTTOM
CAT_EVT_COMMAND_SCROLL_LINEUP
CAT_EVT_COMMAND_SCROLL_LINEDOWN
CAT_EVT_COMMAND_SCROLL_PAGEUP
CAT_EVT_COMMAND_SCROLL_PAGEDOWN
CAT_EVT_COMMAND_SCROLL_THUMBTRACK
CAT_EVT_COMMAND_SCROLL_THUMBRELEASE
CAT_EVT_SCROLLWIN_TOP
CAT_EVT_SCROLLWIN_BOTTOM
CAT_EVT_SCROLLWIN_LINEUP
CAT_EVT_SCROLLWIN_LINEDOWN
CAT_EVT_SCROLLWIN_PAGEUP
CAT_EVT_SCROLLWIN_PAGEDOWN
CAT_EVT_SCROLLWIN_THUMBTRACK
CAT_EVT_SCROLLWIN_THUMBRELEASE
CAT_EVT_SPIN_UP
CAT_EVT_SPIN_DOWN
CAT_EVT_SPIN
CAT_EVT_SPINCTRL
CAT_EVT_SPLITTER_SASH_POS_CHANGING
CAT_EVT_SPLITTER_SASH_POS_CHANGED
CAT_EVT_SPLITTER_UNSPLIT
CAT_EVT_SPLITTER_DOUBLECLICKED
CAT_EVT_SYS_COLOUR_CHANGED
CAT_EVT_TASKBAR_MOVE
CAT_EVT_TASKBAR_LEFT_DOWN
CAT_EVT_TASKBAR_LEFT_UP
CAT_EVT_TASKBAR_RIGHT_DOWN
CAT_EVT_TASKBAR_RIGHT_UP
CAT_EVT_TASKBAR_LEFT_DCLICK
CAT_EVT_TASKBAR_RIGHT_DCLICK
CAT_EVT_TREE_BEGIN_DRAG
CAT_EVT_TREE_BEGIN_RDRAG
CAT_EVT_TREE_END_DRAG
CAT_EVT_TREE_BEGIN_LABEL_EDIT
CAT_EVT_TREE_END_LABEL_EDIT
CAT_EVT_TREE_GET_INFO
CAT_EVT_TREE_SET_INFO
CAT_EVT_TREE_ITEM_EXPANDED
CAT_EVT_TREE_ITEM_EXPANDING
CAT_EVT_TREE_ITEM_COLLAPSED
CAT_EVT_TREE_ITEM_COLLAPSING
CAT_EVT_TREE_SEL_CHANGED
CAT_EVT_TREE_SEL_CHANGING
CAT_EVT_TREE_KEY_DOWN
CAT_EVT_TREE_DELETE_ITEM
CAT_EVT_TREE_ITEM_ACTIVATED
CAT_EVT_TREE_ITEM_RIGHT_CLICK
CAT_EVT_TREE_ITEM_MIDDLE_CLICK
CAT_EVT_TREE_ITEM_MENU
CAT_EVT_UPDATE_UI
CAT_EVT_UPDATE_UI_RANGE
CAT_EVT_HYPERLINK
CAT_EVT_SOCKET
CAT_EVT_SOCKET_ALL
CAT_EVT_SOCKET_INPUT
CAT_EVT_SOCKET_OUTPUT
CAT_EVT_SOCKET_CONNECTION
CAT_EVT_SOCKET_LOST
CAT_EVT_CALENDAR
CAT_EVT_CALENDAR_SEL_CHANGED
CAT_EVT_CALENDAR_DAY
CAT_EVT_CALENDAR_MONTH
CAT_EVT_CALENDAR_YEAR
CAT_EVT_CALENDAR_WEEKDAY_CLICKED
CAT_EVT_STC_CHANGE
CAT_EVT_STC_STYLENEEDED
CAT_EVT_STC_CHARADDED
CAT_EVT_STC_SAVEPOINTREACHED
CAT_EVT_STC_SAVEPOINTLEFT
CAT_EVT_STC_ROMODIFYATTEMPT
CAT_EVT_STC_KEY
CAT_EVT_STC_DOUBLECLICK
CAT_EVT_STC_UPDATEUI
CAT_EVT_STC_MODIFIED
CAT_EVT_STC_MACRORECORD
CAT_EVT_STC_MARGINCLICK
CAT_EVT_STC_NEEDSHOWN
CAT_EVT_STC_POSCHANGED
CAT_EVT_STC_PAINTED
CAT_EVT_STC_USERLISTSELECTION
CAT_EVT_STC_URIDROPPED
CAT_EVT_STC_DWELLSTART
CAT_EVT_STC_DWELLEND
CAT_EVT_STC_START_DRAG
CAT_EVT_STC_DRAG_OVER
CAT_EVT_STC_DO_DROP
CAT_EVT_STC_ZOOM
CAT_EVT_STC_HOTSPOT_CLICK
CAT_EVT_STC_HOTSPOT_DCLICK
CAT_EVT_STC_CALLTIP_CLICK);

1;

=head1 NAME

Catalyst::Engine::Wx::Event - Catalyst wxPerl Engine events manager

=head1 SYNOPSIS

In your wx classes you can attach events the traditionnal way and then
call the Catalyst controllers by calling CATALYST_EVT.

    # Attach events
    EVT_BUTTON( $self, $self->{button}, sub {
        CAT_EVT($self, 'Root->hello_world')
    });

You can pass parameters along with your event:

    EVT_BUTTON( $self, $self->{button}, sub {
        CAT_EVT($self, 'Root->hello_world', { message => $self->{message}->GetValue } )
    });

You can also name your controls and get them automatically added to 
your request's parameters, then you simply use the appropriate event
for the control

	my $ctrl = Wx::TextCtrl->new($self, -1, "", wxDefaultPosition, wxDefaultSize);
    $ctrl->SetName('message');
    
    CAT_EVT_BUTTON( $self, $self->{button}, 'Root->hello_world');

    # Root->hello_world should receive a message parameter with the value stored in
    # the control

=head1 DESCRIPTION

Catalyst::Engine::Wx::Event is the module that you can use to attach events to 
your controls and to trigger Catalyst controllers.

=head2 CAT_EVT

Calls a Catalyst controller either by its path or by its representation.
Where Root->hello_world is the representation of the hello_world sub in the 
Root module.

You can also call it with '/hello_world'.

The following is equivalent to loading the application if you have not defined
a bootstrap option.

    CAT_EVT(undef, 'Root->default');


=head2 CAT_QUIT

This event quits the loop and exits the applications.

For exemple this exits the application when you close the window.

    EVT_CLOSE( $window, sub { CAT_EVT_QUIT; } );

=head1 AUTHORS

Eriam Schaffter, C<eriam@cpan.org> and the Catalyst and wxPerl team.

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it 
under the same terms as Perl itself.

=cut
