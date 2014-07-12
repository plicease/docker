FROM plicease/myperl:5.20.0
MAINTAINER Graham Ollis <plicease@cpan.org>

# workaround for undeclared dep in YAML::XS
RUN tcsh -c 'cpanm Test::Base'

RUN tcsh -c 'cpanm PlugAuth'
RUN tcsh -c 'cpanm PlugAuth::Client'
RUN tcsh -c 'cpanm PlugAuth::Plugin::Audit'
RUN tcsh -c 'cpanm PlugAuth::Plugin::AuthenSimple'
RUN tcsh -c 'cpanm PlugAuth::Plugin::DBIAuth'
RUN tcsh -c 'cpanm PlugAuth::Plugin::Finger'
RUN tcsh -c 'cpanm PlugAuth::Plugin::LDAP'

RUN sudo tcsh -c 'rm -f /etc/sudoers.d/prep; deluser ollisg prep; deluser ollisg sudo; delgroup prep'

EXPOSE 3000
CMD exec plugauth daemon
