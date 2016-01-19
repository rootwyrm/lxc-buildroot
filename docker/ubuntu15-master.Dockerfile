FROM: ubuntu:15.10
## The magic begins...
MAINTAINER    Phillip "RootWyrm" Jaenke <docker@rootwyrm.com>

## We always use label.
LABEL com.rootwyrm.vendor="RootWyrm"
LABEL com.rootwyrm.version="0.0.1"
LABEL com.rootwyrm.branch="master"
LABEL com.rootwyrm.release=""
LABEL com.rootwyrm.vcs-type="git"
LABEL com.rootwyrm.changelog-url="/CHANGELOG"

LABEL com.rootwyrm.rootcore.base="ubuntu:15.10"
LABEL com.rootwyrm.rootcore.depends=""
LABEL com.rootwyrm.rootcore.provides="buildroot"
LABEL com.rootwyrm.rootcore.svctype="compiler, builder"
LABEL com.rootwyrm.rootcore.ports="22"
LABEL com.rootwyrm.rootcore.qnap_compatible="false"
LABEL com.rootwyrm.rootcore.synology_compatible="false"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    build-essential bash bc binutils build-essential bzip2 cpio g++ \
    gcc git gzip libncurses5-dev make mercurial whois patch perl \
    python rsync sed tar unzip wget logrotate

# Sometimes Buildroot need proper locale, e.g. when using a toolchain
# based on glibc.
RUN locale-gen en_US.utf8

WORKDIR /root
RUN git clone git://git.buildroot.net/buildroot --depth=1
WORKDIR /root/buildroot

## Ubuntu has a daily apt check, we still need to run the update
RUN echo "30 6 * * 0,2,4 root /usr/bin/apt-get update -qq" >> /etc/crontab
RUN echo "# Comment to disable weekly repository updates." >> /etc/crontab
RUN echo "0 9 * * 0 root cd /root/buildroot ; /bin/git pull" >> /etc/crontab
ADD ../etc/logrotate.d/ /etc/logrotate.d/

RUN touch .config
RUN touch kernel.config
VOLUME /root/buildroot/dl
VOLUME /buildroot_output

## Enable ssh
EXPOSE 22

CMD ["/bin/bash"]
