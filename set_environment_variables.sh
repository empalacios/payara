#!/bin/bash
./asadmin --user=admin --passwordfile=/home/vagrant/payarapwd --port 4848 create-system-properties user_bd=user
./asadmin --user=admin --passwordfile=/home/vagrant/payarapwd --port 4848 create-system-properties password_bd=password
./asadmin --user=admin --passwordfile=/home/vagrant/payarapwd --port 4848 create-system-properties url_bd=jdbc\\:postgresql\\://localhost\\:5432/mybd
