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

LABEL com.rootwyrm.rootcore.base="centos:6"
LABEL com.rootwyrm.rootcore.depends=""
LABEL com.rootwyrm.rootcore.provides="buildroot"
LABEL com.rootwyrm.rootcoresvctype="compiler, builder"
LABEL com.rootwyrm.rootcore.ports="22"
LABEL com.rootwyrm.rootcore.qnap_compatible="false"
LABEL com.rootwyrm.rootcore.synology_compatible="false"


ENV yuminst="/usr/bin/yum -q -y"

RUN $yuminst install yum-plugin-security
RUN $yuminst install bc bzip2 gcc gcc-c++ flex git ncurses-devel crontabs \
    mercurial perl-ExtUtils-MakeMaker patch rsync tar unzip wget bison \
    which 
RUN $yuminst update-minimal --security
RUN $yuminst update

## Now make sure we update yum regularly, just in case...
RUN echo "30 6 * * 0,2,4 root /usr/bin/yum -q -y update >> /var/log/yum_update.log" >> /etc/crontab
RUN echo "# Uncomment to automatically update stable repository." >> /etc/crontab
RUN echo "#0 9 * * 0 root cd /root/buildroot ; /bin/git pull" >> /etc/crontab
ADD etc/logrotate.d/ /etc/logrotate.d/
    
#RUN locale-gen en_US.utf8

WORKDIR /root
RUN git clone git://git.buildroot.net/buildroot -b 2015.11.x --depth=1
WORKDIR /root/buildroot

RUN touch .config
RUN touch kernel.config

# Shared download volume for multiple instances
VOLUME /root/buildroot/dl
# Do NOT share output volumes
VOLUME /buildroot_output

CMD ["/bin/bash"]
