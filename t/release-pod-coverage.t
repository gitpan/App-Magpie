#!perl
#
# This file is part of App-Magpie
#
# This software is copyright (c) 2011 by Jerome Quelin.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#

BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

# This file was automatically generated by Dist::Zilla::Plugin::PodCoverageTests.

use Test::Pod::Coverage 1.08;
use Pod::Coverage::TrustPod;

all_pod_coverage_ok({ coverage_class => 'Pod::Coverage::TrustPod' });
