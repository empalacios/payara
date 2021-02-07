# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "debian/contrib-buster64"

  config.vm.network "private_network", ip: "192.168.56.5"

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

    # maven
      wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip -O /opt/apache-maven-3.6.3-bin.zip 2>/dev/null
      unzip /opt/apache-maven-3.6.3-bin.zip -d /opt
      export PATH="$PATH:/opt/apache-maven-3.6.3/bin"
      echo 'export PATH="$PATH:/opt/apache-maven-3.6.3/bin"' >> /etc/profile.d/env.sh

    # payara
      payaradir=payara5
      wget https://s3-eu-west-1.amazonaws.com/payara.fish/Payara+Downloads/5.2020.7/payara-5.2020.7.zip -O payara-5.2020.7.zip 2>/dev/null
      unzip payara-5.2020.7.zip -d /opt
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
        sleep 20
        sh /vagrant/set_environment_variables.sh
  SHELL
end

