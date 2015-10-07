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

## Build the Framework

```
cd $GOPATH/src/github.com/basho-labs/riak-mesos && make
```

or for a faster build with lower RAM requirements:

```
cd $GOPATH/src/github.com/basho-labs/riak-mesos && TAGS=dev make
```

## Creating Native / Platform Specific Builds

By default, the build process will include a Debian Ubuntu image in the binary to support multiple platforms using chroot. To build the framework without relying on chroot, everything can be built natively:

```
# Rebuild all Erlang artifacts
cd $GOPATH/src/github.com/basho-labs/riak-mesos && TAGS='"rel native"' make rebuild_all_native
# Recompile the framework only
cd $GOPATH/src/github.com/basho-labs/riak-mesos && TAGS='"rel native"' make
# Create packages in the `_build/` directory
cd $GOPATH/src/github.com/basho-labs/riak-mesos && make package
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
