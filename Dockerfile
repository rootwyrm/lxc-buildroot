## The magic begins...
MAINTAINER    Phillip "RootWyrm" Jaenke <docker@rootwyrm.com>

## We always use label.
LABEL com.rootwyrm.vendor="RootWyrm"
LABEL com.rootwyrm.version="0.0.1"
LABEL com.rootwyrm.branch="master"
LABEL com.rootwyrm.release=""
LABEL com.rootwyrm.vcs-type="git"
LABEL com.rootwyrm.changelog-url="/CHANGELOG"

LABEL com.rootwyrm.rootcore.depends=""
LABEL com.rootwyrm.rootcore.provides="buildroot"
LABEL com.rootwyrm.rootcoresvctype="compiler, builder"
LABEL com.rootwyrm.rootcore.ports="22"
LABEL com.rootwyrm.rootcore.qnap_compatible="false"
LABEL com.rootwyrm.rootcore.synology_compatible="false"

FROM  centos:6

ENV yuminst="/bin/yum -y"

RUN $yuminst bash bc binutils bzip2 cpio g++ gcc git gzip ncurses-devel ncurses-libs \
    make mercurial perl-ExtUtils-MakeMaker patch python rsync sed tar unzip wget
    
RUN locale-gen en_US.utf8

WORKDIR /root
RUN git clone git://git.buildroot.net/buildroot -b 2015.11.x --depth=1
WORKDIR /root/buildroot

RUN touch .config
RUN touch kernel.config
VOLUME /root/buildroot/dl
VOLUME /buildroot_output

CMD ["/bin/bash"]
