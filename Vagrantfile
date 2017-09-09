# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.network "forwarded_port", guest: 4000, host: 4000 
  config.vm.synced_folder "infrastructure/srv/salt/", "/srv/salt/"

  config.vm.provision :salt do |salt|
    salt.masterless = true
    salt.minion_config = "infrastructure/vagrant-minion"
    salt.run_highstate = true
  end

end
