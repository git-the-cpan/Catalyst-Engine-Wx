package Catalyst::View::Wx;

use warnings;
use strict;

use base qw/Catalyst::View/;

use NEXT;
use Class::Inspector;
use Data::Dumper;

our $VERSION = '0.1';

=head1 NAME

Catalyst::View::Wx - Wx View Class

=head1 SYNOPSIS

=cut
sub new {
   my ( $class, $c, $arguments ) = @_;
   my $self = bless {}, $class;
   
   my $config = {
      %{ $class->config },
      %{ $arguments },
   };
   
   $self->config($config);
   
   return $self;
}

sub process {
   my ($self, $c) = @_;
   
   my $module = $c->stash->{class} || $c->action;
   $module =~ s/\//::/g;
   
   if (defined $self->config->{NAMESPACE}) {
      $module = $self->config->{NAMESPACE}.'::'.$module;
   }
   
   unless (Class::Inspector->loaded($module)) {
      require Class::Inspector->filename($module);
   }
   
   if (my $code = $module->can('new') ) {
      $code->($module, @_);
   }

#   $c->stash->{_displayed} = 1;
   return 1; 
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
