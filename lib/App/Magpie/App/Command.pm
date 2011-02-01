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
  $App::Magpie::App::Command::VERSION = '1.110320';
}
# ABSTRACT: base class for sub-commands

use App::Cmd::Setup -command;

# -- public methods


1;


=pod

=head1 NAME

App::Magpie::App::Command - base class for sub-commands

=head1 VERSION

version 1.110320

=head1 DESCRIPTION

This module is the base class for all sub-commands. It doesn't do
anything special currently but trusting methods for pod coverage.

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

