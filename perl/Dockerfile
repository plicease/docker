FROM plicease/clang:3.4.2
MAINTAINER Graham Ollis <plicease@cpan.org>

# my user
RUN useradd -M -s /bin/tcsh ollisg
RUN mkdir /home/ollisg /home/ollisg/bin
ADD bashrc /home/ollisg/.bashrc
ADD cshrc /home/ollisg/.cshrc
RUN chown -R ollisg:ollisg /home/ollisg
RUN adduser ollisg sudo

# sudo (which can be removed later)
RUN /usr/sbin/addgroup prep
RUN adduser ollisg prep
RUN echo "%prep ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/prep

# more my user
USER ollisg
ENV HOME /home/ollisg
ENV SHELL /bin/tcsh
ENV PERL_CPANM_OPT --mirror http://mirror.sydney.wdlabs.com/cpan/ --mirror-only
ENV visual nano
ENV editor nano
WORKDIR /home/ollisg

# perlbrew
RUN curl -L http://install.perlbrew.pl | bash
RUN tcsh -c 'perlbrew init'
RUN tcsh -c 'perlbrew install -j 4 --clang perl-5.20.0 -v'
RUN tcsh -c 'perlbrew lib create perl-5.20.0@dev'
RUN tcsh -c 'perlbrew switch perl-5.20.0@dev'
RUN rm -rf perl5/perlbrew/build/* perl5/perlbrew/*.log perl5/perlbrew/dists/*

# cpanminus + update all old modules
RUN tcsh -c 'curl -L http://cpanmin.us | perl - App::cpanminus -v'
RUN tcsh -c 'cpanm NX::cpanoutdated -v'
RUN tcsh -c 'nxcpan-outdated | cpanm -v'

# default to tcsh for interactive shell
ENTRYPOINT ["/bin/tcsh", "-c"]
CMD exec tcsh
