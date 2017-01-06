VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :ansible do |ansible_config|
    ansible_config.vm.box = "bento/centos-6.7"
    ansible_config.vm.hostname = "ansible.example.com"
    ansible_config.vm.network "private_network", ip: "192.168.120.100"
    ansible_config.vm.provision "shell", path: "configure_nodes.sh"
    config.vm.provider "virtualbox" do |v|
       v.memory = 192
       v.cpus = 1
    end
  end

  config.vm.define :web01 do |web01_config|
    web01_config.vm.box = "bento/centos-6.7"
    web01_config.vm.hostname = "web01.example.com"
    web01_config.vm.network "private_network", ip: "192.168.120.101"
    web01_config.vm.provision "shell", path: "configure_nodes.sh"
    config.vm.provider "virtualbox" do |v|
       v.memory = 192
       v.cpus = 1
    end
  end

  config.vm.define :db01 do |db01_config|
    db01_config.vm.box = "bento/centos-6.7"
    db01_config.vm.hostname = "db01.example.com"
    db01_config.vm.network "private_network", ip: "192.168.120.102"
    db01_config.vm.provision "shell", path: "configure_nodes.sh"
    config.vm.provider "virtualbox" do |v|
       v.memory = 192
       v.cpus = 1
    end
  end

end
