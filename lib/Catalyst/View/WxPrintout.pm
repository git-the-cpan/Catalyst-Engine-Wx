package Catalyst::View::WxPrintout;

use warnings;
use strict;
no strict 'refs';

use base qw/Catalyst::View/;

use Wx::Print;

our $VERSION = "0.02_05";

=head1 NAME

Catalyst::View::WxPrintout - WxPrintout View Class

=head1 SYNOPSIS

UNUSABLE YET :)

=cut
sub new {
   my ( $class, $c, $arguments ) = @_;
    my $self = bless {}, $class;

    return $self;
}


sub process {
    my ($self, $c) = @_;

    
    my $module = $c->stash->{'class'};

    if (defined $self->config->{NAMESPACE}) {
        $module = $self->config->{NAMESPACE}.'::'.$module;
    }

    unless (Class::Inspector->loaded($module)) {
        require Class::Inspector->filename($module);
    }
    
    if (my $code = $module->can('new')) {
        eval { $self->{'canvas'} = $code->($module); };
        die $@ if $@;
    }

    
#    $printer->Print( undef, $printout, 0 );
#    
#    $printout->Destroy;

    return; 
}

sub DESTROY {
   my ($self) = shift;
 
}

package Catalyst::View::WxPrintout::printout;

use strict;
use base qw(Wx::Printout);

sub new {
  my $class = shift;
  my $canvas = shift;
  my $this = $class->SUPER::new( @_ );

  $this->{'canvas'} = $canvas;

  return $this;
}

sub GetPageInfo {
  my $this = shift;

#  Wx::LogMessage( "GetPageInfo" );

  return ( 1, 2, 1, 2 );
}

sub HasPage {
  my $this = shift;

#  Wx::LogMessage( "HasPage: %d", $_[0] );

  return $_[0] == 1 || $_[0] == 2;
}

sub OnBeginDocument {
  my $this = shift;

#  Wx::LogMessage( "OnBeginDocument: %d, %d", @_ );

  return $this->SUPER::OnBeginDocument( @_ );
}

sub OnEndDocument {
  my $this = shift;

#  Wx::LogMessage( "OnEndDocument" );

  return $this->SUPER::OnEndDocument();
}

sub OnBeginPrinting {
  my $this = shift;

#  Wx::LogMessage( "OnBeginPrinting" );

  return $this->SUPER::OnBeginPrinting();
}

sub OnEndPrinting {
  my $this = shift;

#  Wx::LogMessage( "OnEndPrinting" );

  return $this->SUPER::OnEndPrinting();
}

sub OnPrintPage {
  my( $this, $page ) = @_;
  my $dc = $this->GetDC();

  # we need to set the appropriate scale
  my( $x_size, $y_size ) = ( 80, 80);

  my( $xmargin, $ymargin ) = ( 0, 0 );
  # total size ( borders on top/bottom, left/right )
  my( $xsize, $ysize ) = ( $x_size + 2 * $xmargin, $y_size + 2 * $ymargin );

  # dc size
  my( $xdc, $ydc ) = $dc->GetSizeWH();

  # calculate the scale
  my( $xscale, $yscale ) = ( $xdc / $xsize, $ydc / $ysize );
  my $scale = ( $xscale < $yscale ) ? $xscale : $yscale;
  # center the image
  my( $xoff, $yoff ) = ( ( $xdc - ( $scale * $x_size ) ) / 2.0,
                         ( $ydc - ( $scale * $y_size ) ) / 2.0 );

    print $dc."\n";
    print ref($dc)."\n";
    print " $scale, $scale \n";
    print " $xoff, $yoff \n";

  # set the DC origin / scale
  $dc->SetUserScale( $scale, $scale );
  $dc->SetDeviceOrigin( $xoff, $yoff );

  if( $page == 1 ) { $this->{'canvas'}->OnDraw( $dc ); }
  if( $page == 2 ) { } # empty page
}



=head1 AUTHORS

Eriam Schaffter, C<eriam@cpan.org>

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it 
under the same terms as Perl itself.

=cut

1;
