# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provision :shell, :path => "infrastructure/vagrant_provision.sh"
  config.vm.network "forwarded_port", guest: 4000, host: 4000
  config.vm.synced_folder ".", "/home/vagrant", type: "virtualbox"
end
