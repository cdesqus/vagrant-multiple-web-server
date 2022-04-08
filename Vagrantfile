Vagrant.configure("2") do |config|
  config.vm.provision :shell, inline: "apt-get update -y"

  config.vm.define "vmsosmed" do |vmsosmed|
    vmsosmed.vm.hostname = "vmsosmed"
    vmsosmed.vm.provision :shell, path: "vmsosmed.sh"
    vmsosmed.vm.box = "ubuntu/bionic64"
    vmsosmed.vm.network "private_network",ip: "192.168.56.20"
    #vmsosmed.vm.network "forwarded_port", guest: 80, host:80
    vmsosmed.vm.provider "virtualbox" do |v|
        v.memory = 1094
        v.cpus = 1
     end
  end

  config.vm.define :vmlp do |vmlp|
    vmlp.vm.hostname = "vmlp"
    vmlp.vm.provision :shell, path: "vmlp.sh"
    vmlp.vm.box = "ubuntu/bionic64"
    vmlp.vm.network "private_network",ip: "192.168.56.21"
    #vmlp.vm.network "forwarded_port", guest: 80, host:80
    vmlp.vm.provider "virtualbox" do |v|
        v.memory = 1094
        v.cpus = 1
     end

  end

  config.vm.define :vmwp do |vmwp|
    vmwp.vm.hostname = "vmwp"
    vmwp.vm.provision :shell, path: "vmwp.sh"
    vmwp.vm.box = "ubuntu/bionic64"
    vmwp.vm.network "private_network",ip: "192.168.56.22"
    #vmlp.vm.network "forwarded_port", guest: 80, host:80
    vmwp.vm.provider "virtualbox" do |v|
        v.memory = 1094
        v.cpus = 1
     end

  end

  
end
