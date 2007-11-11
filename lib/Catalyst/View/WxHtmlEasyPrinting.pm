package Catalyst::View::WxHtmlEasyPrinting;

use warnings;
use strict;
no strict 'refs';

use base qw/Catalyst::View/;

use Wx::Html;

our $VERSION = "0.02_05";

=head1 NAME

Catalyst::View::WxHtmlEasyPrinting - WxHtmlEasyPrinting View Class

=head1 SYNOPSIS

=cut
sub new {
   my ( $class, $c, $arguments ) = @_;
    my $self = bless {}, $class;

    return $self;
}


sub process {
    my ($self, $c) = @_;
    
    $self->{'Wx::HtmlEasyPrinting'} = Wx::HtmlEasyPrinting->new( $c->stash->{title} );
    $self->{'Wx::HtmlEasyPrinting'}->PrintFile( $c->stash->{file} );
    
    return; 
}

sub DESTROY {
   my ($self) = shift;
 
}


=head1 AUTHORS

Eriam Schaffter, C<eriam@cpan.org>

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it 
under the same terms as Perl itself.

=cut

1;
