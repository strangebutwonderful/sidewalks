#!/usr/bin/env bash

# Takes ruby version and optionally starter gems (e.g. "2.0.0 rails haml")

source /usr/local/rvm/scripts/rvm

rvm use --install $1

shift

if (( $# ))
then gem install $@
fi