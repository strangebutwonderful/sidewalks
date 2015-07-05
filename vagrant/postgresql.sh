#!/bin/bash

# See also:
# * https://gorails.com/setup/ubuntu/14.04

echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

apt-get update

apt-get -qq install postgresql-9.4 postgresql-contrib libpq-dev
sudo -u postgres createuser --createdb vagrant
