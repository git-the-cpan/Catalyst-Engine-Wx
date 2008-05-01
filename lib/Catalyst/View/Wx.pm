package Catalyst::View::Wx;

use warnings;
use strict;
no strict 'refs';

use base qw/Catalyst::View/;

use NEXT;
use Class::Inspector;
use Module::Reload; 
use Data::Dumper;

our $VERSION = "0.02_06";

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
      
      my $module  = $c->stash->{class}
                     || $c->stash->{template}
                     || $c->action;
      my $method  = 'new';
      my $code;
      
      $module =~ s/\//::/g if $module =~ /\//;
      
      if (ref($module) eq 'ARRAY') {
         my $tmpmodule = shift(@{$module});
         $method = shift(@{$module});
         $module = $tmpmodule;
      }
      elsif ($module =~ /->/) {
         ($module, $method) = split (/->/, $module);
      }
      elsif ($module =~ /::/) {
         my (@module_name) = split (/::/, $module);
         $method = pop @module_name;
         $module = join ('::', @module_name);
      }

      if ($c->stash->{'_parent'}) {
      
         #$c->log->info(" _parent ".$c->stash->{'_parent'} );
         #
         #print "trying to run method $module of parent \n";
         
         if ($code = $c->stash->{'_parent'}->can($module)) {
            eval { $code->($c->stash->{'_parent'}, @_); };
            $c->log->debug($@) if $@;
            print $@ if $@;
         }
         elsif ($code = $c->stash->{'_parent'}->can($method)) {
            eval { $code->($c->stash->{'_parent'}, @_); };
            $c->log->debug($@) if $@;
            print $@ if $@;
         }
         else {
            $c->log->debug(ref($c->stash->{'_parent'})." does not implement ".$module);
            Wx::MessageBox("The package ".ref($c->stash->{'_parent'})." does not \nimplement the method '".$module."' !", 'Error');
         }      
      
      }
      else {
         

   
         #print ("View is processing: $module -> $method \n");
         #$c->log->info("View is processing: $module -> $method");
   
      
         if (defined $self->config->{NAMESPACE}) {
            $module = $self->config->{NAMESPACE}.'::'.$module;
         }
         
         if ($self->config->{DEBUG}) {
            Module::Reload->check;
         }
         
         unless (Class::Inspector->loaded($module)) {
            require Class::Inspector->filename($module);
         }

         if ($code = $module->can($method)) {
            eval { $code->($module, @_); };
            $c->log->debug($@) if $@;
            print $@ if $@;
         }
         else {
            $c->log->debug($module." does not implement ".$method);
         }      
        
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
