#!/bin/sh

echo "Installing phantomjs"
apt-get -qq install build-essential chrpath git-core libssl-dev libfontconfig1-dev libicu48

# cd /tmp
# PHANTOMJS_VERSION=1.9.7
# wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2
# tar xjf phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2

# ln -s /tmp/phantomjs-${PHANTOMJS_VERSION}-linux-x8664/bin/phantomjs /usr/local/share/phantomjs
# ln -s /tmp/phantomjs-${PHANTOMJS_VERSION}-linux-x8664/bin/phantomjs /usr/local/bin/phantomjs
# ln -s /tmp/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64/bin/phantomjs /usr/bin/phantomjs