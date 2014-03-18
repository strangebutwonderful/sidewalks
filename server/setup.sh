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
# Install chef
###
echo "Installing chef"
gem install chef --no-rdoc --no-ri --conservative

###
# Install postgresql 9.3
###

# # make a /etc/apt/sources.list.d/pgdg.list file with the contents of:
# # deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main
# # to support postgresql.org apt-get downloads
# CONTENTS="deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main"
# PGDG="/etc/apt/sources.list.d/pgdg.list" 
# if [ ! -f "$PGDG" ]; then
#   echo "Configuring for postgresql"
#   echo $CONTENTS >> $PGDG

#   # Add secure key for postgres.org
#   wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

#   # update apt-get to allow postgres package to be found
#   apt-get -qq update
#   apt-get -qq upgrade  
# fi

# # Download the actual postgres package (will be available as psql)
# echo "Installing postgresql"
# apt-get -qq install postgresql-9.3

# # Problems: does not setup postgres with proper 'vagrant' user account and password,
# # workaround http://serverfault.com/a/325596/96516