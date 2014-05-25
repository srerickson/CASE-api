$:.unshift "./app"

require 'grape'
require 'mongoid'
Mongoid.load!("config/mongoid.yml", :development)

require 'models'
require 'api'

run API