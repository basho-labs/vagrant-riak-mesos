#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export HOME=/home/ubuntu

# Install mesos, marathon, zk, docker
apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)
echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" |  sudo tee /etc/apt/sources.list.d/mesosphere.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo "deb https://get.docker.io/ubuntu docker main" | sudo tee /etc/apt/sources.list.d/docker.list
apt-get -y update > /dev/null
apt-get -y upgrade > /dev/null
apt-get -y install software-properties-common
add-apt-repository -y ppa:openjdk-r/ppa
apt-get -y update > /dev/null
apt-get -y install make git gcc g++ curl
apt-get -y install python-dev libcppunit-dev libunwind8-dev autoconf autotools-dev libltdl-dev libtool autopoint libcurl4-openssl-dev libsasl2-dev
apt-get -y install openjdk-8-jdk default-jre python-setuptools python-protobuf
update-java-alternatives -s /usr/lib/jvm/java-1.8.0-openjdk-amd64
apt-get -y install libprotobuf-dev protobuf-compiler
apt-get -y install mesos marathon
apt-get -y install lxc-docker

service zookeeper restart
service mesos-slave restart
service mesos-master restart
service marathon restart

# Install Erlang
apt-get -y update
apt-get -y upgrade
apt-get install -y build-essential autoconf libncurses5-dev openssl libssl-dev fop xsltproc unixodbc-dev libpam0g-dev

mkdir -p $HOME/bin
cd $HOME/bin
curl -O https://raw.githubusercontent.com/spawngrid/kerl/master/kerl
chmod a+x kerl
./kerl build git git://github.com/basho/otp.git OTP_R16B02_basho8 R16B02-basho8
./kerl install R16B02-basho8 ~/erlang/R16B02-basho8
. ~/erlang/R16B02-basho8/activate

# Install Golang
apt-get -y update
apt-get -y upgrade
apt-get -y install git bison mercurial autoconf
cd $HOME/ && bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
gvm install go1.4
gvm use go1.4
gvm install go1.5
mkdir -p /mnt/go

# Debootstrap
apt-get -y install debootstrap

# DCOS Prereq
apt-get -y install python-pip
apt-get -y install zip
apt-get -y install s3cmd

echo '# Erlang' >> $HOME/.bashrc
echo '. $HOME/erlang/R16B02-basho8/activate' >> $HOME/.bashrc
echo '# Golang' >> $HOME/.bashrc
echo '[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"' >> $HOME/.bashrc
echo 'gvm use go1.5' >> $HOME/.bashrc
echo 'export GOPATH=/mnt/go' >> $HOME/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin:$HOME/.gvm/gos/go1.4/bin:$HOME/bin' >> $HOME/.bashrc

# Fix permissions
chown -R ubuntu /mnt/go
chgrp -R ubuntu /mnt/go
chown -R ubuntu $HOME
chgrp -R ubuntu $HOME

# TODO: change default mesos data directories
mkdir -p /mnt/mesos
echo "/mnt/mesos" > /etc/mesos-master/work_dir
echo "/mnt/mesos" > /etc/mesos-slave/work_dir
