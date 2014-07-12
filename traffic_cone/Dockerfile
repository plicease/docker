FROM plicease/myperl:5.20.0
MAINTAINER Graham Ollis <plicease@cpan.org>

RUN tcsh -c 'cpanm -v App::TrafficCone'
RUN sudo tcsh -c 'rm -f /etc/sudoers.d/prep; deluser ollisg prep; deluser ollisg sudo; delgroup prep'

EXPOSE 3000
CMD exec traffic_cone
