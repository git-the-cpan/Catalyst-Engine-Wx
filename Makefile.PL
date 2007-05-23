#use ExtUtils::MakeMaker;
use inc::Module::Install;

name 'Catalyst-Engine-Wx';
author 'Eriam Schaffter <eriam@cpan.org>';
license 'perl';
version_from 'lib/Catalyst/Engine/Wx.pm';
abstract_from 'lib/Catalyst/Engine/Wx.pm';

# Build the prerequisite list
requires 'POE'                   =>   '0.38';
requires 'POE::Loop::Wx'         =>   0;
requires 'Alien::wxWidgets'      =>   0;
requires 'Wx'                    =>   0;
requires 'Class::Inspector'      =>   0;

WriteAll();
