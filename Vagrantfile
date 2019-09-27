Vagrant.configure("2") do |config|


    #first tachka
    

    ubuntu_host = "ubuntuserver"
    centos_host = "centosserver"
    ubuntu_ip = "192.168.100.1" 
    centos_ip = "192.168.100.2"


    $ubuntu_script = <<-SCRIPT
        apt install git -y
        echo 
    SCRIPT


    config.vm.define "ubuntu_vm" do |ubuntu_vm|
        ubuntu_vm.vm.box = "generic/ubuntu1804"
        ubuntu_vm.vm.hostname = "#{ubuntu_host}"
        
        ubuntu_vm.vm.provider "virtualbox" do |vb|
            vb.memory = "2048"
            vb.cpus = "2"
        end

        ubuntu_vm.vm.network "private_network", ip: "#{ubuntu_ip}"
        ubuntu_vm.provision "shell", inline: $ubuntu_script
    end

    
    #second tachka

    $centos_script = <<-SCRIPT
        yum install git -y
    SCRIPT


    config.vm.define "centos_vm" do |centos_vm| 
        centos_vm.vm.box = "centos/7"
        centos_vm.vm.hostname = "#{centos_host}"
        centos_vm.vm.provider "virtualbox" do |vb|
            vb.memory = "2048"
            vb.cpus = "2"
        end

        centos_vm.vm.network "private_network", ip: "#{centos_ip}"
        centos_vm.provision "shell", inline: $centos_script
    end

    
end
