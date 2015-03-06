# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = ENV['VAGRANT_BOX'] || "ubuntu/trusty64"

  config.berkshelf.enabled = true
  config.vm.provision :chef_zero do |chef|
    chef.add_recipe 'mysql-fabric'
  end
end
