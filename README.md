[![Gem Version](https://img.shields.io/gem/v/capistrano-puma-sic.svg)](https://rubygems.org/gems/capistrano-puma-sic)
[![Dependencies](https://img.shields.io/gemnasium/SICSoftwareGmbH/capistrano-puma.svg)](https://gemnasium.com/SICSoftwareGmbH/capistrano-puma)


# Capistrano::Puma

Manages puma with capistrano.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-puma-sic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-puma-sic


## Usage

Require in `Capfile` to use the default task:

```ruby
require 'capistrano/puma'
require 'capistrano/puma/workers' # Optional: Adds worker tasks
```

Configurable options, shown here with defaults:

```ruby
set :puma_roles,            :app
set :puma_env,              -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
set :puma_user,             -> { fetch(:app_user, nil) }
set :puma_conf,             -> { File.join(release_path, 'config', 'puma', "#{fetch(:stage)}.rb") }
set :puma_pid,              -> { File.join(shared_path, 'tmp', 'pids', 'puma.pid') }
set :puma_state,            -> { File.join(shared_path, 'tmp', 'pids', 'puma.state') }
set :puma_restart_strategy, 'phased-restart'
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SICSoftwareGmbH/capistrano-puma.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
