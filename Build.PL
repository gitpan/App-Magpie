
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'File::Find' => '0',
    'File::Temp' => '0',
    'Module::Build' => '0.3601',
    'Test::More' => '0.88'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Mageia Perl Integration Easy',
  'dist_author' => [
    'Jerome Quelin <jquelin@gmail.com>'
  ],
  'dist_name' => 'App-Magpie',
  'dist_version' => '1.110320',
  'license' => 'perl',
  'module_name' => 'App::Magpie',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'App::Cmd::Setup' => '0',
    'FindBin' => '0',
    'LWP::UserAgent' => '0',
    'Path::Class' => '0',
    'perl' => '5.012'
  },
  'script_files' => [
    'bin/magpie'
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
