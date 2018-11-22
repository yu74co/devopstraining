Vagrant.configure("2") do |config| 
    config.vm.box = "bertvv/centos72"
    config.vm.provider "virtualbox" do |vb|
        vb.gui = true
    end

    config.vm.define "server1" do |server1|
        server1.vm.hostname = "server1"
        server1.vm.network "private_network", ip: "192.168.0.10"
        server1.vm.provision "shell", inline: <<-SHELL
#      sudo yum update -y
          sudo  echo "192.168.0.11 server2" >> /etc/hosts
          sudo yum install -y mc git
          mkdir /home/vagrant/git_dir
          cd /home/vagrant/git_dir
          git clone https://github.com/yu74co/devopstraining.git
          cd ./devopstraining
          git config user.name "Yury Semchanka"
          git config user.email "sem.y@tut.by"
          git checkout task2
          cat Task2_file
        SHELL
        server1.vm.provision "file", source: "Vagrantfile", destination: "Vagrantfile"
        server1.vm.provision "shell", inline: <<-SHELL
          sudo cp Vagrantfile ./git_dir/devopstraining/
          cd git_dir/devopstraining/
          git add Vagrantfile
        SHELL
    end

    config.vm.define "server2" do |server2|
        server2.vm.hostname = "server2"
        server2.vm.network "private_network", ip: "192.168.0.11"
        server2.vm.provision "shell", inline: <<-SHELL
          sudo  echo "192.168.0.10 server1" >> /etc/hosts
          sudo yum install -y mc
        SHELL
    end
    
end
