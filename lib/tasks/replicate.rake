require 'replicate'

# Hacked together from
# https://github.com/rtomayko/replicate/blob/master/bin/replicate

namespace :replicate do
  namespace :dump do
    desc <<-DESC
      Dump noises to console

      bin/rake replicate:dump:noises > test.dump
    DESC
    task noises: :environment do

      $stderr.sync = true
      $stdout = $stderr

      # default options
      mode     = nil
      verbose  = false
      quiet    = false
      keep_id  = false
      out      = STDOUT
      force    = false

      script = 'Noise.where_since(2.hours.ago).all'
      usage.call if script.empty?

      Replicate::Dumper.new do |dumper|
        dumper.marshal_to out
        dumper.log_to $stderr, verbose, quiet
        if script == '-'
          code = $stdin.read
          objects = dumper.instance_eval(code, '<stdin>', 0)
        elsif File.exist?(script)
          dumper.load_script script
        else
          objects = dumper.instance_eval(script, '<argv>', 0)
          dumper.dump objects
        end
      end
    end
  end

  desc "Load file into database"
  task :load do
    puts "Run via `replicate` command, example:"
    puts " replicate -r ./config/environment -l < myfile.dump"
  end
end
