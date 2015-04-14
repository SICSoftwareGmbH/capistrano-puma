[![Gem Version](https://img.shields.io/gem/v/capistrano-puma-sic.svg)](https://rubygems.org/gems/capistrano-puma-sic)
[![Dependencies](https://img.shields.io/gemnasium/SICSoftwareGmbH/capistrano-puma.svg)](https://gemnasium.com/SICSoftwareGmbH/capistrano-puma)
[![Code Climate](https://img.shields.io/codeclimate/github/SICSoftwareGmbH/capistrano-puma.svg)](https://codeclimate.com/github/SICSoftwareGmbH/capistrano-puma)

# Capistrano::Puma

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
require 'capistrano/puma/console' # Optional: Adds worker tasks
```

Configurable options, shown here with defaults:

```ruby
set :puma_env, -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
set :puma_roles, :app
set :puma_user, nil # triggers usage of sudo
set :puma_bundle, -> { fetch(:bundle_cmd, :bundle) }
set :puma_bin, :puma
set :pumactl_bin, :pumactl
set :puma_conf, -> { File.join(release_path, 'config', 'puma', "#{fetch(:stage)}.rb") }
set :puma_pid, -> { File.join(shared_path, 'tmp', 'pids', 'puma.pid') }
set :puma_state, -> { File.join(shared_path, 'tmp', 'pids', 'puma.state') }
set :puma_restart_strategy, :restart # valid values: restart, phased-restart
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
