$:.unshift("./app","./app/api","./libs")

ENV["CASE_SECRET"] ||= "89072a1966rf0384470918732409831734hh0987d09348579048570987230498572asdfasdf014895"

require 'rubygems'
require 'grape'
require 'pg'
require 'active_record'


ActiveRecord::Base.establish_connection(
  :adapter  => 'postgresql',
  :host     => "localhost",
  :database => "case",
  :encoding => 'utf8'
)


require 'user'
require 'case'
require 'schema'
require 'field_set'
require 'field_definition'
require 'field_value'

require 'api/api'