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

package App::Magpie::App::Command::bswait;
BEGIN {
  $App::Magpie::App::Command::bswait::VERSION = '1.110390';
}
# ABSTRACT: pause according to build-system recommendations

use LWP::UserAgent;

use App::Magpie::App -command;


# -- public methods

sub description {
"Pauses according to the recommendation of Mageia build-system.
Build-system provides some recommendation on how much time to pause
between 2 packages submission to not overload it - this is known as
throttling."
}

sub opt_spec {
    my $self = shift;
    return (
        [],
        [ 'display|d=s' => "text to display with --verbose", { default=>"sleeping %d seconds\n" } ],
        [ 'nosleep|n!'  => "don't sleep" ],
        [ 'verbose|v!'  => "display time to wait" ],
    );
}

sub execute {
    my ($self, $opts, $args) = @_;

    # allow user-defined eol
    $opts->{display} =~ s/\\n/\n/g;

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    my $response = $ua->head('http://pkgsubmit.mageia.org/');
    die $response->status_line unless $response->is_success;

    my $sleep = $response->header( "x-bs-throttle" );

    printf($opts->{display}, $sleep) if $opts->{verbose};
    sleep($sleep)                    unless $opts->{sleep};
}

1;


=pod

=head1 NAME

App::Magpie::App::Command::bswait - pause according to build-system recommendations

=head1 VERSION

version 1.110390

=head1 DESCRIPTION

This command pauses according to the recommendation of Mageia
build-system. Indeed, instead of pushing all your packages to be
rebuilt, it's better to throttle them one at a time. Build-system
provides some recommendation on how much to pause between 2 packages -
and this command uses this hint to pause accordingly.

=head1 AUTHOR

  Jerome Quelin <jquelin@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


