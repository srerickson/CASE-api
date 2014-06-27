$:.unshift("./app","./app/api","./app/serializers","./libs")

ENV["CASE_SECRET"] ||= "89072a1966rf0384470918732409831734hh0987d09348579048570987230498572asdfasdf014895"

require 'rubygems'
require 'grape'
require 'grape-active_model_serializers'
require 'hashie_rails'
require 'pg'
require 'active_record'
require 'require_all'


config =   ENV['DATABASE_URL'] || {
    adapter: 'postgresql',
    host: "localhost",
    database: "case",
    encoding: 'utf8'
  }

puts config 

ActiveRecord::Base.establish_connection(config)


require_all 'app/models'
require_all 'app/serializers'

require 'api/api'