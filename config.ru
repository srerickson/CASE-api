$:.unshift "./app"

require 'grape'
require 'mongoid'
Mongoid.load!("config/mongoid.yml", :development)

require 'case'
require 'schema'
require 'field_definition'
require 'field_value'

require 'api'

run API