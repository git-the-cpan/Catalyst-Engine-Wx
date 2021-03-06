package Catalyst::View::wxPrinter;

use warnings;
use strict;
no strict 'refs';

use base qw/Catalyst::View/;

use NEXT;
use Class::Inspector;
use Module::Reload; 
use Data::Dumper;

our $VERSION = '0.01_01';

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
   
   $c->stash->{'_displayed'} ||= 0;
   
   if ($c->stash->{'_displayed'} != 1) {
      
      my $module = $c->stash->{class} || $c->action;
      $module =~ s/\//::/g;
      
      if (defined $self->config->{NAMESPACE}) {
         $module = $self->config->{NAMESPACE}.'::'.$module;
      }
      
      if ($ENV{CATALYST_DEBUG}) {
         Module::Reload->check;
      }
      
      unless (Class::Inspector->loaded($module)) {
         require Class::Inspector->filename($module);
      }
      
      if (my $code = $module->can('new')) {
         eval { $code->($module, @_); };
         print $@ if $@;
      }
   
      $c->stash->{'_displayed'} = 1;
   }
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
