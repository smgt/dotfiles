# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  #
  config.vm.provision 'shell', privileged: true, inline: <<-SHELL
    if ! [ -x "$(command -v ansible)" ]; then
      pacman -Syu --noconfirm
      pacman -S ansible --noconfirm
    fi
  SHELL

  config.vm.provision 'shell', privileged: true, inline: <<-SHELL
    set -e
    mkdir -p /home/vagrant/.dotfiles
    cp -r /vagrant/* /home/vagrant/.dotfiles/
    chown -R vagrant /home/vagrant/.dotfiles/
    su - vagrant -c "ansible-galaxy install -r /home/vagrant/.dotfiles/ansible/requirements.yml"
    su - vagrant -c "ansible-playbook --diff \"/home/vagrant/.dotfiles/ansible/main.yml\""
    su - vagrant -c "cd /home/vagrant/.dotfiles/;./link.sh"
  SHELL

  # config.vm.provision 'ansible_local' do |ansible|
  #   ansible.compatibility_mode = '2.0'
  #   ansible.verbose        = true
  #   ansible.install        = false
  #   ansible.playbook = 'main.yml'
  #   ansible.galaxy_role_file = 'requirements.yml'
  #   ansible.provisioning_path = '/vagrant/ansible'
  # end

  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    cd /vagrant
    #./link.sh
    echo derp
  SHELL
end
