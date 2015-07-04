#!/bin/sh

####
# This script can be used to setup development (vagrant) environments
####

###
# Set correct locale
###
echo "Setting locale"
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

###
# Update apt-get
###
echo "Updating apt-get"
apt-get -qq update

echo "Installing libraries from apt-get"
apt-get -qq install curl build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev git-core libpq-dev
