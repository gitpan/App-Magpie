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

package App::Magpie::Action::Old::Module;
BEGIN {
  $App::Magpie::Action::Old::Module::VERSION = '1.111030';
}
# ABSTRACT: module that has a newer version available

use File::ShareDir::PathClass;
use Moose;
use MooseX::Has::Sugar;
use MooseX::SemiAffordanceAccessor;

use App::Magpie::URPM;


# -- private vars

my $sharedir = File::ShareDir::PathClass->dist_dir( 'App-Magpie' );
my %SKIPMOD = do {
    my $skipfile = $sharedir->file( 'modules.skip' );
    my @skips = $skipfile->slurp;
    my %skip;
    foreach my $skip ( @skips ) {
        next if $skip =~ /^#/;
        chomp $skip;
        my ($module, $version, $reason) = split /\s*;\s*/, $skip;
        $skip{$module} = $version;
    }
    %skip;
};

my %SKIPPKG = do {
    my $skipfile = $sharedir->file( 'packages.skip' );
    my @skips = $skipfile->slurp;
    my %skip;
    foreach my $skip ( @skips ) {
        next if $skip =~ /^#/;
        chomp $skip;
        my ($pkg, $reason) = split /\s*;\s*/, $skip;
        $skip{$pkg} = 1;
    }
    %skip;
};


# -- public attributes


has name     => ( ro, isa => "Str", required );
has oldver   => ( ro, isa => "Str" );
has newver   => ( ro, isa => "Str" );
has is_core  => ( rw, isa => "Bool" );
has packages => ( ro, isa => "ArrayRef", lazy_build, auto_deref );

sub _build_packages {
    my ($self) = @_;
    my $urpm = App::Magpie::URPM->instance;
    my $module = $self->name;
    my @pkgs   = $urpm->packages_providing( $module );

    $self->set_is_core( scalar( grep { $_->name =~ /^perl(-base)?$/ } @pkgs ) );
    return [ grep { $_->name !~ /^perl(-base)?$/ } @pkgs ];
}


# -- public methods


sub category {
    my ($self) = @_;
    my @pkgs   = $self->packages;
    my $iscore = $self->is_core;

    if ( exists $SKIPMOD{ $self->name } ) {
        return "ignored" if not defined $SKIPMOD{ $self->name };
        return "ignored" if $self->newver eq $SKIPMOD{ $self->name }
    }

    if ( $iscore ) {
        return "core"       if scalar(@pkgs) == 0;
        return "strange"    if scalar(@pkgs) >= 2;
        # scalar(@pkgs) == 1;
        return "ignored" if exists $SKIPPKG{ $pkgs[0] };
        return "dual-lifed";
    }

    return "orphan"  if scalar(@pkgs) == 0;
    return "strange" if scalar(@pkgs) >= 2;
    # scalar(@pkgs) == 1;
    return "ignored" if exists $SKIPPKG{ $pkgs[0]->name };
    return "normal";
}


__PACKAGE__->meta->make_immutable;
1;


=pod

=head1 NAME

App::Magpie::Action::Old::Module - module that has a newer version available

=head1 VERSION

version 1.111030

=head1 DESCRIPTION

This class represents an installed Perl module that has a newer version
available on CPAN.

=head1 ATTRIBUTES

=head2 name

The name of the module.

=head2 oldver

The version of the module as currently installed.

=head2 newver

The module version, as available on CPAN.

=head2 packages

The Mageia packages holding the module (there can be more than one).
Core packages (perl and perl-base) are excluded from this list.

=head2 is_core

Whether the module is shipped in a core Perl package.

=head1 METHODS

=head2 category

    my $str = $module->category;

Return the module category:

=over 4

=item * C<core> - one of the core packages (perl, perl-base)

=item * C<dual-lifed> - core package + one other package

=item * C<normal> - plain, non-core regular package

=item * C<orphan> - installed package not shipped by a package
(inherited from mandriva, or not yet submitted)

=item * C<strange> - shipped by more than one non-core package

=back

=head1 AUTHOR

Jerome Quelin <jquelin@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

