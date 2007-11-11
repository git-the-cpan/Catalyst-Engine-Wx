package Catalyst::Engine::Wx;

use strict;
use warnings;

sub POE::Kernel::ASSERT_DEFAULT () { 0 }
sub POE::Kernel::TRACE_DEFAULT  () { 0 }

use POE qw( Loop::Wx );
use POE::Session;

use Data::Dumper;
use IO::String;
use URI;

our $VERSION = "0.02_05";

my $uri_proto = URI->new();
my $app;
   
use base 'Catalyst::Engine';
use Errno 'EWOULDBLOCK';

sub new {
   my ( $class ) = @_;
   
   $class->SUPER::new();
}


sub run {
   my ( $self, $class, $options ) = @_;
   
   $options ||= {};
   $self->{bootstrap}  = delete $options->{bootstrap} || '/';
   
   POE::Session->create(
      object_states => [
         $self => [ 
            'EVENT_REQUEST',
            '_PULSE'
         ],
      ],
      inline_states => {
         _start      => sub {    
               my ($kernel, $heap, $session) = @_[KERNEL, HEAP, SESSION];

               $heap->{'class'} = $class;
               
               $kernel->alias_set('catalyst-wxperl');
                        
               POE::Kernel->post('catalyst-wxperl', '_keepalive');
               POE::Kernel->post('catalyst-wxperl', '_PULSE');
            },
         _keepalive  => sub {
               $_[KERNEL]->delay('_keepalive', 20);
            },
         _stop       => sub {
               $_[KERNEL]->delay('_keepalive');
#                exit;
            }
      }
   );

   my $locale = Wx::Locale->new( Wx::Locale::GetSystemLanguage );
   Wx::InitAllImageHandlers();
   $app = Wx::SimpleApp->new;
    
   POE::Kernel->loop_run();
   POE::Kernel->run();
}

sub _PULSE {
   my ($self, $kernel, $heap, $session, $request) = @_[OBJECT, KERNEL, HEAP, SESSION, ARG0];
   
   $heap->{'class'}->handle_request({
      controller  => $self->{bootstrap},
   });
}

sub EVENT_REQUEST {
   my ($self, $kernel, $heap, $session, $request) = @_[OBJECT, KERNEL, HEAP, SESSION, ARG0];
   
   $heap->{'class'}->handle_request($request);
}

sub finalize {
    my ( $self, $c, $request ) = @_;

#    print "finalize request dude !!\n";
}

sub prepare {
   my ( $self, $c, $request ) = @_;
   
   my $controller = $request->{'controller'} || '/';

   if ($controller =~ /\->/) {
      $controller =~ s/^Root//g 
         if $controller =~ /^Root/;
         
      $controller =~ s/\->/\//g;
      $controller =~ s/::/\//g;

      $controller = lc($controller);
   }
   
   $controller = '/'.$controller
      if ($controller !~ /^\//);
  
   foreach (keys %{ $request }) {
      $c->request->parameters->{$_} = $request->{$_};
   }

   my $path = $controller;
   $path =~ s{^/+}{};

   my $uri = $uri_proto->clone;
   $uri->path($path);
   $c->request->uri($uri);
   
   my (@paths,undef) = split(/\//, $controller);
   my $base_path = join('/', @paths);
   
   $base_path ||= '/';
   
   my $base = $uri->clone;
   $base->path_query($base_path);
   $c->request->base($base);
   
   $c->stash->{'_parent'}  = $request->{'parent'};
   $c->stash->{'_event'}   = $request->{'event'};
}

=head1 NAME

Catalyst::Engine::Wx - Catalyst wxPerl Engine

=head1 SYNOPSIS

A script using the Catalyst::Engine::Wx module might look like:

    #!/usr/bin/perl -w

    BEGIN {  $ENV{CATALYST_ENGINE} = 'Wx' }

    use strict;
    use lib '/path/to/MyApp/lib';
    use MyApp;

    MyApp->run;

Combine it with the Catalyst-View-Wx and have Catalyst work
with wxPerl interfaces.

=head1 DESCRIPTION

This is the Catalyst engine specialized for building non-blocking and
multi-platforms desktop applications with the Catalyst framework. It
allows to tie Wx events to Catalyst controllers asynchronously.

It will also allow you to replace html views with Wx views from which you
can access the stash and deals with controllers just like in any other
Catalyst application running a web engine.

You can re-use many Plugins in the Catalyst namespace to authenticate, 
deal with cache, store session data and so on.

See the tests for more informations.

There is also a demo application included.

The following methods are for internal use despite that these don't start
with the classical underscore.

=head2 run

Creates the Catalyst engine that will receive and deals with events coming
from your Wx classes.

You can pass it a bootstrap parameter to inform the engine what controller
holds the main window creation.

    MyApp->run({
	    bootstrap   => 'MyApp->main_window',
    });

Otherwise it will run the default action in the root controller.

=head2 EVENT_REQUEST

Receive and event from the Wx views and send it in the Catalyst flow.

=head2 prepare

Transform an event with parameters into a Catalyst request.

=head2 finalize

Finalize a request and trap errors to display an error message.

=head1 AUTHORS

Eriam Schaffter, C<eriam@cpan.org> and the Catalyst and wxPerl team.

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it 
under the same terms as Perl itself.

=cut

1;
