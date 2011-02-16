
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Carp' => '0',
    'English' => '0',
    'File::Find' => '0',
    'File::Temp' => '0',
    'Module::Build' => '0.3601',
    'Scalar::Util' => '0',
    'Test::More' => '0.94'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Mageia Perl Integration Easy',
  'dist_author' => [
    'Jerome Quelin <jquelin@gmail.com>'
  ],
  'dist_name' => 'App-Magpie',
  'dist_version' => '1.110470',
  'license' => 'perl',
  'module_name' => 'App::Magpie',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'App::Cmd::Setup' => '0',
    'CPAN::Mini' => '0',
    'File::Copy' => '0',
    'FindBin' => '0',
    'LWP::UserAgent' => '0',
    'Log::Dispatchouli' => '0',
    'Moose' => '0',
    'MooseX::Has::Sugar' => '0',
    'Parse::CPAN::Meta' => '1.4401',
    'Parse::CPAN::Packages' => '0',
    'Path::Class' => '0.22',
    'Text::Padding' => '0',
    'perl' => '5.012',
    'version' => '0'
  },
  'script_files' => [
    'bin/magpie',
    'bin/magpie~'
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
