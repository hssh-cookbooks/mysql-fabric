# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = ENV['VAGRANT_BOX'] || "chef/ubuntu-14.04"

  config.vm.provider :virtualbox do |vb|
    vb.memory = 1024
  end

  config.berkshelf.enabled = true

  config.vm.define :node do |node|
    node.vm.hostname 'node'
    node.vm.provision :chef_zero do |chef|
      chef.add_recipe 'mysql-fabric'
    end
  end
end
