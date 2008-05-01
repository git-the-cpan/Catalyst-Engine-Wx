package Catalyst::Log::Wx;

use strict;
use base 'Class::Accessor::Fast';
use Data::Dump;
use Wx qw[:everything];

our $VERSION = "0.02_05";

use Catalyst::Engine::Wx::Event qw(
   CAT_EVT
);

our %LEVELS = ();

__PACKAGE__->mk_accessors('level');
__PACKAGE__->mk_accessors('body');
__PACKAGE__->mk_accessors('abort');
__PACKAGE__->mk_accessors('frame');

{
    my @levels = qw[ debug info warn error fatal ];

    for ( my $i = 0 ; $i < @levels ; $i++ ) {

        my $name  = $levels[$i];
        my $level = 1 << $i;

        $LEVELS{$name} = $level;

        no strict 'refs';

        *{$name} = sub {
            my $self = shift;

            if ( $self->{level} & $level ) {
                $self->_log( $name, @_ );
            }
        };

        *{"is_$name"} = sub {
            my $self = shift;
            return $self->{level} & $level;
        };
    }
}

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new;
    
    
    print "new \n";
     my $locale = Wx::Locale->new( Wx::Locale::GetSystemLanguage );
   Wx::InitAllImageHandlers();
my   $app = Wx::SimpleApp->new;
eval {
    $self->levels( scalar(@_) ? @_ : keys %LEVELS );
    $self->frame(Wx::Frame->new( undef, -1, 'Catalyst::Log::Wx', wxDefaultPosition, [600,400], wxDEFAULT_FRAME_STYLE ));
##   $self->frame->{reloader} = Wx::TextCtrl->new($self->frame, -1, "", wxDefaultPosition, wxDefaultSize, );
    $self->frame->{logger} = Wx::TextCtrl->new($self->frame, -1, "", wxDefaultPosition, wxDefaultSize, wxTE_MULTILINE|wxTE_READONLY);
#
    my $log = Wx::LogTextCtrl->new( $self->frame->{logger} );
    $self->frame->{old_log} = Wx::Log::SetActiveTarget( $log );
#
#	$self->frame->{sizer_2} = Wx::BoxSizer->new(wxVERTICAL);
#	$self->frame->{sizer_2}->Add($self->frame->{reloader}, 0, wxEXPAND, 0);
#	$self->frame->{sizer_2}->Add($self->frame->{logger}, 4, wxEXPAND, 0);
#	$self->frame->SetSizer($self->frame->{sizer_2});
#	$self->frame->{sizer_2}->Fit($self->frame);
#	$self->frame->Layout();
#
##	Wx::Event::EVT_TEXT_ENTER($self->frame, $self->frame->{reloader}->GetId, \&_reload);
#
#	$self->frame->SetSize(Wx::Size->new(600, 400));
#	$self->frame->{logger}->SetFont(Wx::Font->new(8, wxMODERN, wxNORMAL, wxNORMAL, 0, ""));
#
	$self->frame->Show(1)
        if $ENV{CATALYST_DEBUG} == 1;    
    };
    
    print "done \n";
    
    return $self;
}

sub levels {
    my ( $self, @levels ) = @_;
    $self->level(0);
    $self->enable(@levels);
}

sub enable {
    my ( $self, @levels ) = @_;
    $self->{level} |= $_ for map { $LEVELS{$_} } @levels;
}

sub disable {
    my ( $self, @levels ) = @_;
    $self->{level} &= ~$_ for map { $LEVELS{$_} } @levels;
}

sub _dump {
    my $self = shift;
    $self->info( Data::Dump::dump(@_) );
}

sub _log {
    my $self    = shift;
    my $level   = shift;
    my $message = join( "\n", @_ );
    chomp($message);
eval {
    if ($level eq 'error' or $level eq 'fatal') {
        Wx::MessageBox($message, $level);   
    }
    else {
    $self->frame->{logger}->WriteText($message."\n") 
        if $ENV{CATALYST_DEBUG} == 1;
    }
    };
}

#sub _reload {
#	my ($self, $event) = @_;
#	
#   EVT($self, $self->{reloader}->GetValue);
#
#	$event->Skip;
#}
1;

__END__

=head1 NAME

Catalyst::Log::Wx - Catalyst Log Class for Wx engine

=head1 SYNOPSIS


   use Catalyst::Log::Wx;
      
   MyApp->log(Catalyst::Log::Wx->new);


See L<Catalyst>.

=head1 DESCRIPTION

This module provides a log frame for the Wx catalyst engine.

=head1 SEE ALSO

Catalyst.

=head1 AUTHOR

Eriam Schaffter, C<eriam@cpan.org> and the Catalyst and wxPerl team.

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
