use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'FRDCSA::BehaviorTree',
    AUTHOR       => q{Andrew John Dougherty <adougher9@gmail.com>},
    VERSION_FROM => 'lib/FRDCSA/BehaviorTree.pm',
    ABSTRACT     => 'Pure Perl Behavior Tree implementation',
    ( $ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ( 'LICENSE' => 'gpl_3' )
        : () ),
    PL_FILES  => {},
    PREREQ_PM => {
        'Class::MethodMaker' => 2.24,
        'Data::Dumper'       => 2.170,
    },
    TEST_REQUIRES => {
          'Test::More'    => 1.001014,
    },
);
