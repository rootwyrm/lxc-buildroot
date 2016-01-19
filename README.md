# lxc-buildroot
buildroot for LXC/Docker with many tags to support various development environments.

Coming soon: buildroot-buildroot, because why not meta?

## TAGS
* buildroot [git branch 2015.11.x]
  * `centos-2015.11.x` - `centos:6`
  * `centos7-2015.11.x` - `centos:7`
  * `slack-2015.11.x` - [vbatts]/`slackware:latest`
  * `ubuntu15-2015.11.x` - `ubuntu:15.10`
* buildroot [git branch master]
  * `centos-master` - `centos:6`
  * `centos7-master` - `centos:7`
  * `slack-master` - [vbatts]/`slackware:latest`
  * `ubuntu15-master` - `ubuntu:15.10`

## What does it do?
It provides a docker-managed buildroot environment for people who need things like that. Like me. I don't know. Deal with it.

## What other projects does it lean on?
buildroot, CentOS, Ubuntu, Slackware

# DOES IT WORK!?
Yes! If not, give it an hour or so.

[git branch 2015.11.x]:https://git.busybox.net/buildroot/log/?h=2015.11.x
[git branch master]:https://git.busybox.net/buildroot/log/
[vbatts]:https://hub.docker.com/r/vbatts/slackware/
