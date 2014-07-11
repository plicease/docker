FROM debian:wheezy
MAINTAINER Graham Ollis <plicease@cpan.org>

ADD source.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install wget curl tcsh perl-modules clang bzip2 build-essential perl locales sudo adduser nano git
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen -a

RUN useradd -M -s /bin/tcsh ollisg
RUN mkdir /home/ollisg /home/ollisg/bin
ADD bashrc /home/ollisg/.bashrc
ADD cshrc /home/ollisg/.cshrc
RUN chown -R ollisg:ollisg /home/ollisg
RUN adduser ollisg sudo

RUN /usr/sbin/addgroup prep
RUN adduser ollisg prep
RUN echo "%prep ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/prep

USER ollisg
ENV HOME /home/ollisg
ENV SHELL /bin/tcsh
ENV PERL_CPANM_OPT --mirror http://mirror.sydney.wdlabs.com/cpan/ --mirror-only
ENV visual nano
ENV editor nano
WORKDIR /home/ollisg

RUN curl -L http://install.perlbrew.pl | bash
RUN tcsh -c 'perlbrew init'
RUN tcsh -c 'perlbrew install -j 4 --clang perl-5.20.0 -v'
RUN tcsh -c 'perlbrew lib create perl-5.20.0@dev'
RUN tcsh -c 'perlbrew switch perl-5.20.0@dev'
RUN rm -rf perl5/perlbrew/build/* perl5/perlbrew/*.log perl5/perlbrew/dists/*

RUN tcsh -c 'curl -L http://cpanmin.us | perl - App::cpanminus -v'
RUN tcsh -c 'cpanm NX::cpanoutdated -v'
RUN tcsh -c 'nxcpan-outdated | cpanm -v'

