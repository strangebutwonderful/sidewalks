#!/bin/bash

echo "Installing rbenv"

cd /home/vagrant
git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
chmod 777 /home/vagrant/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bashrc
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bashrc

echo "Installing ruby-build"

git clone git://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/vagrant/.bashrc

echo "Installing rbenv-gem-rehash"
git clone https://github.com/sstephenson/rbenv-gem-rehash.git /home/vagrant/.rbenv/plugins/rbenv-gem-rehash

echo "Adding rbenv ruby to PATH"
echo 'export PATH="$HOME/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:$PATH"' >> /home/vagrant/.bashrc

echo "Initializing rbenv"
/home/vagrant/.rbenv/bin/rbenv/rbenv init -
# exec $SHELL

echo "Installing ruby"
/home/vagrant/.rbenv/bin/rbenv install 2.2.2
/home/vagrant/.rbenv/bin/rbenv global 2.2.2
ruby -v

echo "Configuring gems not to install documentation"
echo "gem: --no-ri --no-rdoc" > /home/vagrant/.gemrc

echo "Installing bundler"
cd /vagrant
gem install --no-ri --no-rdoc bundler
