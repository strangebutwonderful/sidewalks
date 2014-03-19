#!/bin/sh

####
# This script can be used to setup development (vagrant) environments
####

###
# Update apt-get
###
echo "Updating apt-get"
apt-get -qq update

apt-get -qq install curl build-essential zlib1g-dev libyaml-dev git-core

### 
# Install basic ruby for chef
###
echo "Installing ruby 1.9.3 for chef"
apt-get -qq -y install ruby1.9.3 build-essential 

###
# Install chef-solo
###
echo "Installing chef & librarian"
gem install chef librarian-chef --no-rdoc --no-ri --conservative
# chef is now installed as `chef-solo`

###
# Download cookbooks for chef
###
echo "Installing cookbooks"
cd /vagrant
librarian-chef install