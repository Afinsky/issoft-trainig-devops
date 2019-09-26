Vagrant.configure("2") do |config|


    #first tachka
    config.vm.define "ubuntu_vm" do |ubuntu_vm|
        ubuntu_vm.vm.box = "generic/ubuntu1804"
        ubuntu_vm.vm.hostname = 'ubuntuserver'
        ubuntu_vm.vm.provider "virtualbox" do |vb|
            vb.memory = "2048"
            vb.cpus = "2"
        end

        ubuntu_vm.vm.network "public_network"
    end

#second tachka
    config.vm.define "centos_vm" do |centos_vm| 
        centos_vm.vm.box = "centos/7"
        centos_vm.vm.hostname = 'centosserver'
        centos_vm.vm.provider "virtualbox" do |vb|
            vb.memory = "2048"
            vb.cpus = "2"
        end

        centos_vm.vm.network "public_network"
    end

    
end
