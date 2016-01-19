FROM  centos:6
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


ENV yuminst="/usr/bin/yum -q -y"

RUN $yuminst install yum-plugin-security
RUN $yuminst install bc bzip2 g++ gcc git ncurses-devel crontabs \
    mercurial perl-ExtUtils-MakeMaker patch rsync tar unzip wget
RUN $yuminst update-minimal --security
RUN $yuminst update

## Now make sure we update yum regularly, just in case...
RUN echo "30 6 * * 0,2,4 root /usr/bin/yum -q -y update >> /var/log/yum_update.log" >> /etc/crontab
RUN echo "/var/log/yum_update.log { 
    missingok 
    weekly 
    create 0600 root root 
    rotate 1 
}" >> /etc/logrotate.d/yum_update
    
#RUN locale-gen en_US.utf8

WORKDIR /root
RUN git clone git://git.buildroot.net/buildroot -b 2015.11.x --depth=1
WORKDIR /root/buildroot

RUN touch .config
RUN touch kernel.config
VOLUME /root/buildroot/dl
VOLUME /buildroot_output

CMD ["/bin/bash"]
