# -*- mode: ruby -*-
# vi: set ft=ruby :

servers = {
    :master1 => '10.0.0.11',
    :master2 => '10.0.0.12',
    :master3 => '10.0.0.13'
}

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.box_check_update = false

  # 自动插入hosts
  # vagrant plugin install vagrant-hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true


  servers.each do |server_name, server_ip|
    config.vm.define server_name do |server_config|
      server_config.vm.hostname = "#{server_name.to_s}"
      server_config.vm.network :private_network, ip: server_ip
      server_config.vm.provider "virtualbox" do |vb|
        vb.name = server_name.to_s
        vb.memory = "2048"
        vb.cpus = 4
      end
    end
  end
end