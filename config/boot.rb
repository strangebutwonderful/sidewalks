# Compatibilty fix for older gems not updated to use RbConfig instead of Config
Object.send :remove_const, :Config
Config = RbConfig

require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
