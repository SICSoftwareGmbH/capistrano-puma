require 'capistrano/puma/utility'

include Capistrano::Puma::Utility

load File.expand_path('../puma/tasks/puma.cap', __FILE__)
