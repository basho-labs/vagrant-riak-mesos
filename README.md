# vagrant-riak-mesos
Vagrant / Ubuntu 14.04 scripts and resources for Riak Mesos Framework

## Vagrant Usage

```
vagrant plugin install vagrant-hostmanager
vagrant up
vagrant reload
```

Log out and back in or start a new shell session, then run the following

```
sudo su ubuntu
cd /vagrant && ./setup-env.sh
```

## Ubuntu Usage

```
sudo apt-get install -y git
sudo -s
git clone https://github.com/basho-labs/vagrant-riak-mesos.git $HOME/vagrant-riak-mesos
cd $HOME/vagrant-riak-mesos && ./provision.sh
```

Reboot the machine, then run the following

```
cd $HOME/vagrant-riak-mesos && ./setup-env.sh
```

## Build Environment

Build the Riak Mesos Framework

```
cd $GOPATH/src/github.com/basho-labs/riak-mesos && make
```

## DCOS setup

To use the DCOS CLI with the Riak Mesos Framework, follow these instructions

```
# DCOS
mkdir -p $HOME/bin/dcos
cd $HOME/bin/dcos && \
    sudo pip install virtualenv && \
    curl -O https://downloads.mesosphere.io/dcos-cli/install.sh && \
    sudo /bin/bash install.sh . http://localhost
```
