$:.unshift("./app","./app/api","./libs")

ENV["CASE_SECRET"] ||= "89072a1966rf0384470918732409831734hh0987d09348579048570987230498572asdfasdf014895"

require 'grape'
require 'mongoid'
Mongoid.load!("config/mongoid.yml", :development)

require 'user'
require 'case'
require 'schema'
require 'field_set'
require 'field_definition'
require 'field_value'

require 'api/api'

run API