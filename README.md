## Sidewalks

[![Code Climate](https://codeclimate.com/github/ajsharma/sidewalks.png)](https://codeclimate.com/github/ajsharma/sidewalks)
[![Coverage Status](https://coveralls.io/repos/ajsharma/sidewalks/badge.png?branch=master)](https://coveralls.io/r/ajsharma/sidewalks?branch=master)
[![Dependency Status](https://gemnasium.com/ajsharma/sidewalks.png)](https://gemnasium.com/ajsharma/sidewalks)
[![Build Status](https://travis-ci.org/ajsharma/sidewalks.png?branch=master)](https://travis-ci.org/ajsharma/sidewalks)

## Ruby on Rails

This application requires:

* Ruby version 2.0.0
* Rails version 3.2.13

Learn more about "Installing Rails":http://railsapps.github.io/installing-rails.html.

## Database

This application uses PostgreSQL with ActiveRecord.

## Development

* Template Engine: ERB
* Testing Framework: Test::Unit
* Front-end Framework: Twitter Bootstrap (Sass)
* Form Builder: None
* Authentication: OmniAuth
* Authorization: CanCan
* Email: Using a Mandrill account (not currently setup)

## Development Environment Installation

### Vagrant 

1. Install VirtualBox from dmg
1. Install Vagrant from pkg
1. Change directory to the `sidewalks` folder
1. Run `vagrant up` to install and start the Vagrant box specified in the `Vagrantfile`, run this in the future to boot up the server
1. Run `vagrant ssh` to connect to the VM box)
1. Once connected, the files for the rails app can be found in the `/vagrant`

## Contributing

If you make improvements to this application, please share with others.

* Fork the project on GitHub.
* Make your feature addition or bug fix.
* Commit with Git.
* Send the author a pull request.

If you add functionality to this application, create an alternative implementation, or build an application that is similar, please contact me and I'll add a note to the README so that others can find your work.

## Credits and Thanks
This application was initially generated with the "rails_apps_composer":https://github.com/RailsApps/rails_apps_composer gem provided by the "RailsApps Project":http://railsapps.github.io/.
