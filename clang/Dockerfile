FROM debian:wheezy
MAINTAINER Graham Ollis <plicease@cpan.org>

# Base system
ADD source.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget curl tcsh perl-modules bzip2 build-essential perl locales sudo adduser nano git bsdtar
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen -a

# CLANG 3.4.2
WORKDIR /usr/local/src
RUN apt-get install -y python groff-base                      && \
    wget http://llvm.org/releases/3.4.2/llvm-3.4.2.src.tar.gz && \
    wget http://llvm.org/releases/3.4.2/cfe-3.4.2.src.tar.gz  && \
    bsdtar xf llvm-3.4.2.src.tar.gz                           && \
    bsdtar xf cfe-3.4.2.src.tar.gz                            && \
    cd /usr/local/src/llvm-3.4.2.src                          && \
    mv ../cfe-3.4.2.src tools/clang                           && \
    ./configure --prefix=/usr/local                           && \
    make                                                      && \
    make install                                              && \
    rm -rf /usr/local/src/*                                   && \
    apt-get purge python groff; apt-get autoremove

WORKDIR /
