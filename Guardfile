#!/usr/bin/env ruby

# -*- mode: ruby -*-
# vi: set ft=ruby :

# More info at https://github.com/guard/guard#readme

# See https://github.com/guard/guard-minitest#options
# for options and details
guard :minitest, all_on_start: false, spring: true do
  # General 1 to 1 matching
  watch(%r{^app/(.+)\.rb$}) { |m| "test/#{m[1]}_test.rb" }

  # Controllers
  watch(%r{^app/controllers/application_controller\.rb$}) { "test/controllers" }
  watch(%r{^app/controllers/(.+)_controller\.rb$}) { |m| "test/functional/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/(.+)_controller\.rb$}) { |m| "test/integration/#{m[1]}_test.rb" }

  # Mailers
  watch(%r{^app/views/(.+)_mailer/.+}) { |m| "test/mailers/#{m[1]}_mailer_test.rb" }

  # Jobs
  watch(%r{^app/jobs/(.+)\.rb$}) { |m| "test/unit/jobs/#{m[1]}_test.rb" }

  # Library files
  # watch(%r{^lib/(.+)\.rb$}) { |m| "test/unit/lib/#{m[1]}_test.rb" }

  # Rake tasks
  watch(%r{^lib/tasks/(.+)\.rake$}) { |m| "test/unit/lib/tasks/#{m[1]}_test.rb" }

  # Tests
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) { "test" }
end
