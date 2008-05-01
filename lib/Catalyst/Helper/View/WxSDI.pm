package Catalyst::Helper::View::WxSDI;

use strict;
use File::Spec;

our $VERSION = "0.02_05";

sub mk_compclass {
    my ( $self, $helper, @args ) = @_;
    my $file = $helper->{file};
    
    $helper->render_file( 'compclass', $file );
    $self->mk_templates( $helper, @args );
}

sub mk_templates {
    my ( $self, $helper ) = @_;
    my $base = $helper->{base},;
    my $ldir = File::Spec->catfile( $base, 'lib', $helper->{app}.'Wx' );

    $helper->mk_dir($ldir);

    foreach my $file (qw(Default Hello)) {
        $helper->render_file( $file,
            File::Spec->catfile( $ldir, $file.".pm" ) );
    }
    
    my $sdir = File::Spec->catfile( $base, 'script' );
    $helper->mk_dir($sdir);
    $helper->render_file( 'script', File::Spec->catfile( $sdir, lc($helper->{app})."_wx.pl" ) );
}

=head1 NAME

Catalyst::Helper::View::WxSDI - Helper for Wx view which builds a skeleton for a SDI 
wxPerl application

=head1 SYNOPSIS

# use the helper to create the view module and templates

    $ script/myapp_create.pl view Wx WxSDI

# add something like the following to your main application module

    sub hello_world : Global {
        my ( $self, $c ) = @_;
        $c->stash->{class} = 'Hello';
        $c->stash->{message}  ||= $c->req->param('message') || 'No message';
    }
    
    sub default : Private {
        my ( $self, $c ) = @_;
        $c->stash->{class} = 'Default';
    }
    
    sub end : Private {
        my ( $self, $c ) = @_;
        $c->forward('MyApp::View::Wx');
    }

If you have a RenderView make sure it does not try to render other views 
before the Wx one.

Then after simply do a 

    perl script/myapp_wx.pl

and you should get started.

Have fun !

=head1 DESCRIPTION

This helper module creates a Wx View module.  It goes further than
Catalyst::Helper::View::WxApp in that it creates for you a window
with a menu, status bar and a few other things to get you started.

It also build 

=head2 METHODS

=head3 mk_compclass

Generates the component class.

=head3 mk_templates

Generates the templates.

=cut

=head1 SEE ALSO

L<Catalyst>, L<Catalyst::View::Wx>, L<Catalyst::Helper>,
L<Catalyst::Helper::View::TT>, L<Catalyst::Engine::Wx>

=head1 AUTHOR

Eriam Schaffter <eriam@cpan.org> and with code inspired by 
Catalyst::Helper::View::TTSite by Andy Wardley <abw@cpan.org>

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;

__DATA__

__compclass__
package [% class %];

use strict;
use base 'Catalyst::View::Wx';

__PACKAGE__->config({
    NAMESPACE       => '[% app %]Wx',
    CATALYST_VAR    => 'Catalyst',
});


=head1 NAME

[% class %] - Catalyst wxPerl View

=head1 SYNOPSIS

See L<[% app %]>

=head1 DESCRIPTION

Catalyst wxPerl View.

=head1 AUTHOR

[% author %]

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

__Default__
package [% app %]Wx::Default;

use strict;
use warnings;

use Wx ':everything';

use Catalyst::Engine::Wx::Event qw(
   CAT_EVT_BUTTON
   CAT_EVT_QUIT
   CAT_EVT
   CAT_EVT_CLOSE
);

use base 'Wx::Frame';

sub new {
    # We receive from the view all the necessary things
    my ($class, $catalyst, $c ) = @_;
    
    # We create the parent window
    my $self = $class->SUPER::new( undef, -1, 'Default', [0, 0], [475,300] );

	# Menu Bar
	$self->{menubar} = Wx::MenuBar->new();
	my $wxglade_tmp_menu = Wx::Menu->new();
	$wxglade_tmp_menu->Append(wxID_EXIT, "Exit", "");
	$self->{menubar}->Append($wxglade_tmp_menu, "File");
	$wxglade_tmp_menu = Wx::Menu->new();
	$wxglade_tmp_menu->Append(wxID_ABOUT, "About ..", "");
	$self->{menubar}->Append($wxglade_tmp_menu, "Help");
	$self->SetMenuBar( $self->{menubar} );

    # Status Bar
	$self->{statusbar} = $self->CreateStatusBar(1, 0);    
 	$self->{statusbar}->SetStatusWidths(-1);
	$self->{statusbar}->SetStatusText('Status Bar Text', 0) 	

    # Sizing stuff
	$self->{sizer_1} = Wx::BoxSizer->new(wxVERTICAL);
	$self->{sizer_1}->Add($self->{message}, 0, wxEXPAND, 0);
	$self->{sizer_1}->Add($self->{button}, 0, wxEXPAND, 0);
	$self->SetSizer($self->{sizer_1});
	$self->{sizer_1}->Fit($self);
	$self->Layout();
	$self->Centre();
    
    # Display the window
    $self->Show(1);
   
    # Log something just in case
    Wx::LogMessage( "Welcome to [% app %] powered by Catalyst::Engine::Wx !" );
   
    # Events are there bro 
    CAT_EVT_MENU( $self, wxID_ABOUT, 'Root->about' );
    CAT_EVT_MENU( $self, wxID_EXIT, sub { CAT_EVT_QUIT; } ); 
    CAT_EVT_CLOSE( $self, sub { CAT_EVT_QUIT; } );
    
    return 1;
}

1;
__About__
package [% app %]Wx::About;

use strict;
use warnings;

use Wx ':everything';

sub new {
   my ($class, $catalyst, $c ) = @_;

   Wx::MessageBox( "[% app %], (c) [% author %] \n" .
                    "wxPerl $Wx::VERSION, " . wxVERSION_STRING,
                    "About FileZ", wxOK|wxCENTRE, $self );
}

1;

__script__

BEGIN {
    $ENV{CATALYST_ENGINE} ||= 'Wx';
    require Catalyst::Engine::Wx;
}  

use FindBin;
use lib "$FindBin::Bin/../lib";

use strict;
use warnings;

use Wx qw[ :everything ]; 

require [% app %];
use Catalyst::Log::Wx;

[% app %]->log(Catalyst::Log::Wx->new);

[% app %]->run({
   bootstrap   => 'Root->default',
});

1;
