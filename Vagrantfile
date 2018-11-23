Vagrant.configure("2") do |config| 
    config.vm.box = "bertvv/centos72"
    config.vm.provider "virtualbox" do |vb|
        vb.gui = true
    end

    config.vm.define "server1" do |server1|
        server1.vm.hostname = "server1"
        server1.vm.network "private_network", ip: "192.168.0.10"
        server1.vm.provision "shell", inline: <<-SHELL
          yum update -y
          echo "192.168.0.11 server2" >> /etc/hosts
          echo "192.168.0.12 server3" >> /etc/hosts
          yum install -y mc httpd
        SHELL
    end

    config.vm.define "server2" do |server2|
        server2.vm.hostname = "server2"
        server2.vm.network "private_network", ip: "192.168.0.11"
        server2.vm.provision "shell", inline: <<-SHELL
          echo "192.168.0.10 server1" >> /etc/hosts
          echo "192.168.0.12 server3" >> /etc/hosts
          yum install -y mc tomcat
        SHELL
    end
    
    config.vm.define "server3" do |server3|
        server3.vm.hostname = "server3"
        server3.vm.network "private_network", ip: "192.168.0.12"
        server3.vm.provision "shell", inline: <<-SHELL
          echo "192.168.0.10 server1" >> /etc/hosts
          echo "192.168.0.11 server2" >> /etc/hosts
          sudo yum install -y mc tomcat
        SHELL
    end
    
end
