# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'.freeze

# Use a custom name to allow simple app creation once the vagrant vm is up'ed
APPLICATION_NAME = (File.basename(Dir.getwd).to_s || 'MyApplication').downcase

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'ubuntu/trusty64'

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"
  # config.vm.box_url = "http://files.vagrantup.com/trusty64.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network 'forwarded_port', guest: 3000, host: 3000
  config.vm.network 'forwarded_port', guest: 8888, host: 8888

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network 'private_network', ip: '192.168.33.10'

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # X11 forwarding over SSH connections is enabled. Defaults to false.
  config.ssh.forward_x11 = true

  # custom fix for "stdin: is not a tty" error (https://github.com/mitchellh/vagrant/issues/1673)
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder '.', '/vagrant', type: 'nfs'

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider 'virtualbox' do |vb|
    host = RbConfig::CONFIG['host_os']

    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else # sorry Windows folks, I can't help you
      cpus = 2
      mem = 1024
    end

    vb.customize ['modifyvm', :id, '--memory', mem]
    vb.customize ['modifyvm', :id, '--cpus', cpus]

    vb.customize ['guestproperty', 'set', :id, '/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold', 5000]
  end

  # View the documentation for the provider you're using for more
  # information on available options.

  config.vm.provision :shell, path: 'vagrant/ubuntu.sh'
  config.vm.provision :shell, path: 'vagrant/ruby.sh'
  config.vm.provision :shell, path: 'vagrant/nodejs.sh'
  config.vm.provision :shell, path: 'vagrant/phantomjs.sh'
  config.vm.provision :shell, path: 'vagrant/postgresql.sh'
end
