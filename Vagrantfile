# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.synced_folder "../data", "/vagrant_data", disabled: true

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = "512"
  end

  config.vm.define "router" do |router|
    router.vm.network "private_network", ip: "192.168.10.2"
    router.vm.network "private_network", ip: "192.168.20.2"
  end

  config.vm.define "node1" do |node1|
    node1.vm.network "private_network", ip: "192.168.10.10"
    # delete default gw
    node1.vm.provision "shell",
      run: "always",
      inline: "ip route del default"
  end

  config.vm.define "node2" do |node2|
    node2.vm.network "private_network", ip: "192.168.10.11"
    # delete default gw
    node2.vm.provision "shell",
      run: "always",
      inline: "ip route del default"
  end

  config.vm.define "server" do |server|
    server.vm.network "private_network", ip: "192.168.20.20"
    # delete default gw
    server.vm.provision "shell",
      run: "always",
      inline: "ip route del default"
  end

end
