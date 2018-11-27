Vagrant.configure("2") do |config| 
    config.vm.box = "bertvv/centos72"
    config.vm.provider "virtualbox" do |vb|
        vb.gui = true
    end

    config.vm.define "server1" do |server1|
        server1.vm.hostname = "server1"
        server1.vm.network "private_network", ip: "192.168.0.10"
        server1.vm.network "forwarded_port", guest: 80, host: 8010
        server1.vm.provision "shell", inline: <<-SHELL
          yum install -y mc httpd
          echo -e "192.168.0.11 server2\n192.168.0.12 server3" >> /etc/hosts
          cp /vagrant/mod_jk.so /etc/httpd/modules/
          echo -e "\nLoadModule jk_module modules/mod_jk.so\n\
                JkWorkersFile conf/workers.properties\n\
                JkShmFile /tmp/shm\n\
                JkLogFile logs/mod_jk.log\n\
                JkLogLevel info\n\
                JkMount /test* lb\n" >> /etc/httpd/conf/httpd.conf
          echo -e "worker.list=lb\n\
                worker.lb.type=lb\n\
                worker.lb.balance_workers=server2, server3\n\
                worker.server2.host=server2\n\
                worker.server2.port=8009\n\
                worker.server2.type=ajp13\n\
                worker.server3.host=server3\n\
                worker.server3.port=8009\n\
                worker.server3.type=ajp13\n" >> /etc/httpd/conf/workers.properties
          systemctl enable httpd
          systemctl start httpd
          firewall-cmd --permanent --zone=public --add-port=80/tcp --add-port=22/tcp
          systemctl restart firewalld
        SHELL
    end

    config.vm.define "server2" do |server2|
        server2.vm.hostname = "server2"
        server2.vm.network "private_network", ip: "192.168.0.11"
        server2.vm.provision "shell", inline: <<-SHELL
          echo -e "192.168.0.10 server1\n192.168.0.12 server3" >> /etc/hosts
          yum install -y mc tomcat tomcat-webapps tomcat-admin-webapps
          mkdir /usr/share/tomcat/webapps/test
          echo -e "TOM &nbsp;&nbsp;&nbsp;&nbsp; 1<br> &nbsp;&nbsp;&nbsp;&nbsp;CAT" > /usr/share/tomcat/webapps/test/index.html 
          systemctl enable tomcat 
          systemctl start tomcat
          firewall-cmd --permanent --zone=public --add-port=8009/tcp
          systemctl restart firewalld
        SHELL
    end
    
    config.vm.define "server3" do |server3|
        server3.vm.hostname = "server3"
        server3.vm.network "private_network", ip: "192.168.0.12"
        server3.vm.provision "shell", inline: <<-SHELL
          echo -e "192.168.0.10 server1\n192.168.0.11 server2" >> /etc/hosts
          sudo yum install -y mc tomcat tomcat-webapps tomcat-admin-webapps
          mkdir /usr/share/tomcat/webapps/test
          echo -e "&nbsp;&nbsp;&nbsp;&nbsp; CAT  <br>TOM &nbsp;&nbsp;&nbsp;&nbsp;  2" > /usr/share/tomcat/webapps/test/index.html
          systemctl enable tomcat 
          systemctl start tomcat
          firewall-cmd --permanent --zone=public --add-port=8009/tcp
          systemctl restart firewalld
        SHELL
    end
    
end
