# -*- mode: ruby -*-
# vi: set ft=ruby :

# Install these plugins

# vagrant plugin install vagrant-hostmanager

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #Setup hostmanager config to update the host files
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  config.vm.provision :hostmanager
  config.vm.synced_folder "./../riak-erlang-mesos", "/riak-erlang-mesos"

  config.vm.box = "ubuntu/trusty64"

  config.vm.provider :virtualbox do |vb, override|
    vb.customize ["modifyvm", :id, "--memory", 2048,  "--cpus", "2"]

    override.vm.hostname = "mesos-dev"
    override.vm.network :private_network, ip: "192.168.0.30"
    override.vm.network :forwarded_port, guest: 5050, host: 5050
    override.vm.network :forwarded_port, guest: 8080, host: 8080
  end

  config.vm.provision 'shell', path: 'provision.sh', run: 'once'

end
