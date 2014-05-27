require 'grape'
require 'mongoid'

Mongoid.load!("config/mongoid.yml", :development)