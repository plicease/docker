use strict;
use warnings;
use v5.10;
use autodie qw( :all );
use Text::Template;
use Path::Class qw( file dir );
use File::chdir;

foreach our $version (qw( 3.4.2 ))
{
  local $CWD = 'clang';
  my $template = Text::Template->new(TYPE => 'FILE', SOURCE => 'Dockerfile.template');
  file('Dockerfile')->spew($template->fill_in(PACKAGE => 'main'));  
  system 'docker', 'build', '-rm', "-t=plicease/clang:$version", '.';
}

system 'docker', 'tag', 'plicease/clang:3.4.2', 'plicease/clang:latest';
