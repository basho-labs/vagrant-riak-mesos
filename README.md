# vagrant-riak-mesos
Vagrant / Ubuntu 14.04 scripts and resources for Riak Mesos Framework

## Vagrant Usage

```
vagrant plugin install vagrant-hostmanager
vagrant up
vagrant reload
```

## Ubuntu Usage

```
sudo -s
git clone https://github.com/basho-labs/vagrant-riak-mesos.git
cd vagrant-riak-mesos
./provision.sh
```

## Build Environment

Add the following to `~/.bashrc` (or just run the commands per session)

```
# Erlang
. $HOME/erlang/R16B02-basho8/activate
# Golang
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
gvm use go1.4
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
```

Log out and back in or start a new shell session, then run the following

```
cd vagrant-riak-mesos
./setup-env.sh
```

Build the Riak Mesos Framework

```
cd $GOPATH/src/github.com/basho-labs/riak-mesos
make
```