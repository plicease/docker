FROM debian:wheezy
MAINTAINER Graham Ollis <plicease@cpan.org>

# Base system
ADD source.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget curl tcsh perl-modules bzip2 build-essential perl locales sudo adduser nano git openjdk-7-jdk
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen -a

# my user
WORKDIR /
RUN useradd -M -s /bin/tcsh ollisg
RUN mkdir /home/ollisg /home/ollisg/bin
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
ENV visual nano
ENV editor nano
WORKDIR /home/ollisg

# scala 2.11.1
RUN wget http://downloads.typesafe.com/scala/2.11.1/scala-2.11.1.deb && \
    sudo dpkg -i scala-2.11.1.deb                                    && \
    rm -f scala-2.11.1.deb

# default to scala
ENTRYPOINT ["/bin/tcsh", "-c"]
CMD scala
