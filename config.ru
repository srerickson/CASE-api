$:.unshift "./app"

require 'grape'
require 'mongoid'
Mongoid.load!("config/mongoid.yml", :development)


require 'case'
require 'schema'
require 'field_set'
require 'field_definition'
require 'field_value'


require 'api/schemas'
require 'api/field_sets'
require 'api/api'




run API