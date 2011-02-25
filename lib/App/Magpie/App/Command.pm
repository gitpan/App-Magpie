#
# This file is part of App-Magpie
#
# This software is copyright (c) 2011 by Jerome Quelin.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.012;
use strict;
use warnings;

package App::Magpie::App::Command;
BEGIN {
  $App::Magpie::App::Command::VERSION = '1.110560';
}
# ABSTRACT: base class for sub-commands

use App::Cmd::Setup -command;
use Moose;
use MooseX::Has::Sugar;

use App::Magpie;


# -- public attributes


has magpie => (
    ro, lazy,
    isa     => "App::Magpie",
    default => sub { App::Magpie->new; }
);


# -- public methods


sub log_init {
    my ($self, $opts) = @_;
    $self->magpie->logger->set_muted(1) if $opts->{quiet};
    $self->magpie->logger->set_debug(1) if $opts->{verbose};
}



sub verbose_options {
    return (
        [ "Logging options" ],
        [ 'verbose|v' => "display extra information" ],
        [ 'quiet|q'   => "be quiet unless error"     ],
    );
}

1;


=pod

=head1 NAME

App::Magpie::App::Command - base class for sub-commands

=head1 VERSION

version 1.110560

=head1 DESCRIPTION

This module is the base class for all sub-commands. It provides some
methods to control logging.

=head1 ATTRIBUTES

=head2 magpie

The L<App::Magpie> object responsible for the real operations.

=head1 METHODS

=head2 log_init

    $cmd->log_init($opts);

Initializes the C<logger> attribute of C<magpie> depending on the
value of verbose options.

=head2 verbose_options

    my @opts = $self->verbose_options;

Return an array of verbose options to be used in a command's C<opt_spec>
method. Those options can then be used by C<log_init()>.

=for Pod::Coverage::TrustPod description
    opt_spec
    execute

=head1 AUTHOR

Jerome Quelin <jquelin@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

