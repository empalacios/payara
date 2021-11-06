# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "debian/contrib-buster64"

  config.vm.network "private_network", ip: "192.168.56.5"
  config.vm.network "forwarded_port", guest: 4848, host: 4848

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update

    apt-get install -y unzip

    apt-get install -y apache2

    # java
      apt-get install -y openjdk-11-jdk-headless

    # configurando apache para ser usado como proxy
      a2dissite 000-default
      a2enmod proxy_http
      cp /vagrant/proxy-8080.conf /etc/apache2/sites-available
      a2ensite proxy-8080
      systemctl restart apache2

    # payara
      payaradir=payara5
      wget https://s3-eu-west-1.amazonaws.com/payara.fish/Payara+Downloads/5.2020.7/payara-5.2020.7.zip -O payara-5.2020.7.zip 2>/dev/null
      unzip payara-5.2020.7.zip -d /opt 2>/dev/null
      useradd payara -m
      chown -R payara:payara /opt/$payaradir
      su - payara
      cd /opt/$payaradir/glassfish/bin
      cp /vagrant/payara_set_password_file /home/vagrant/payarapwd
      ./asadmin --user=admin --passwordfile=/home/vagrant/payarapwd change-admin-password --domain_name domain1
      ./asadmin start-domain
      cp /vagrant/payara_password_file /home/vagrant/payarapwd
      ./asadmin --user=admin --passwordfile=/home/vagrant/payarapwd enable-secure-admin
      ./asadmin stop-domain
      ./asadmin start-domain
      chown -R payara:payara /opt/$payaradir
      ./asadmin create-service --serviceuser payara domain1
      ./asadmin stop-domain
      /etc/init.d/payara_domain1 start
      # variables del sistema
        sleep 10
        sh /vagrant/set_environment_variables.sh
  SHELL
end

