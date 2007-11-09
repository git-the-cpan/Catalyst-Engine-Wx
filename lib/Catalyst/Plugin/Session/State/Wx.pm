package Catalyst::Plugin::Session::State::Wx;
use base qw/Catalyst::Plugin::Session::State Class::Accessor::Fast/;

use strict;
use warnings;

use next;

our $VERSION = "0.02_03";

BEGIN { __PACKAGE__->mk_accessors(qw/_deleted_session_id/) }

our $SESSIONS = ();

sub setup_session {
    my $c = shift;

    $c->NEXT::setup_session(@_);
}

sub set_session_id {
    my ( $c, $sid ) = @_;

    $SESSIONS->{'sid'} = $sid;

    return $c->NEXT::set_session_id($sid);
}

sub get_session_id {
    my $c = shift;

    if ( !$c->_deleted_session_id and $SESSIONS->{'sid'} ) { 
        my $sid = $SESSIONS->{'sid'};
        $c->log->debug(qq/Found sessionid "$sid" in cookie/) if $c->debug;
        return $sid if $sid;
    }

    $c->NEXT::get_session_id(@_);
}

sub delete_session_id {
    my ( $c, $sid ) = @_;
    
    $c->_deleted_session_id(1); # to prevent get_session_id from returning it

    delete $SESSIONS->{'sid'};

    $c->NEXT::delete_session_id($sid);
}

__PACKAGE__

__END__

=pod

=head1 NAME

Catalyst::Plugin::Session::State::Wx - Maintain session using in process memory for the Wx engine.

=head1 SYNOPSIS

    use Catalyst qw/Session Session::State::Wx Session::Store::Foo/;

=head1 DESCRIPTION

Generally, L<Catalyst::Plugin::Session> requires that the session ID is 
stored on the client but since with the Wx engine the engine and the client
is in the same memory space we just need to store the session sid locally.

=head1 EXTENDED METHODS

=over 4

=item setup_session

It just does nothing special.

=back

=head1 SEE ALSO

L<Catalyst>, L<Catalyst::Plugin::Session>.

=head1 AUTHORS

This module is derived from L<Catalyst::Plugin::Session::State::Cookie> code, and
has been heavily modified since.

Andrew Ford
Andy Grundman
Christian Hansen
Yuval Kogman, C<nothingmuch@woobling.org>
Marcus Ramberg
Sebastian Riedel
and Eriam Schaffter for putting this together for the Wx engine.

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
