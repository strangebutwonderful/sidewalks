#!/bin/sh

echo "Copying database config"
cp -n /vagrant/config/database.example.yml /vagrant/config/database.yml

echo "Copying application config"
cp -n /vagrant/config/application.example.yml /vagrant/config/application.yml
