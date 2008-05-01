use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Catalyst::Engine::Wx',
    AUTHOR        => 'Eriam Schaffter <eriam@cpan.org>',
    VERSION_FROM  => 'lib/Catalyst/Engine/Wx.pm',
    ABSTRACT_FROM => 'lib/Catalyst/Engine/Wx.pm',
    LICENSE       => 'perl',
    PL_FILES      => {},
    PREREQ_PM     => {
        'Test::More' => 0,
        'version'    => 0,
        'POE'               => '0.38',
        'POE::Loop::Wx'     => '0.03',
        'Alien::wxWidgets'  => 0,
        'Wx'                => '0.67',
        'Class::Inspector'  => 0,
        'Module::Reload'    => 0,
        'Catalyst'          => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'Catalyst-Engine-*' },
);

