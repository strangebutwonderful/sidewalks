#!/bin/bash

echo "Installing rbenv"

cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

echo "Installing ruby-build"

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

echo "Installing rbenv-gem-rehash"

git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.2.2
rbenv global 2.2.2
ruby -v

echo "Configuring gems not to install documentation"
echo "gem: --no-ri --no-rdoc" > ~/.gemrc

cd /vagrant
gem install bundler
