$:.unshift("./app","./app/api","./app/serializers","./libs")

ENV["CASE_SECRET"] ||= "89072a1966rf0384470918732409831734hh0987d09348579048570987230498572asdfasdf014895"
ENV["RACK_ENV"] ||= "development"

VERSION = '0.2'

require 'rubygems'
require 'grape'
require 'grape-active_model_serializers'
require 'hashie_rails'
require 'pg'
require 'active_record'
require 'require_all'

require 'carrierwave'
require 'carrierwave/orm/activerecord'


### ActiveRecord config

config = ENV['DATABASE_URL'] || {
    adapter: 'postgresql',
    host: "localhost",
    database: "case",
    encoding: 'utf8'
  }

ActiveRecord::Base.establish_connection(config)



### Carrierwave config

ENV["FILE_STORAGE"] ||= "file"
CarrierWave.configure do |config|
  config.root =  File.expand_path '../public', __FILE__
  config.cache_dir = File.expand_path '../tmp/uploads', __FILE__
  if ENV["FILE_STORAGE"] == "fog"
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['AWS_SECRET_KEY']
    }
    config.fog_directory  = 'partlab-case'
  end
end



### Logging 

if ENV['RACK_ENV'] == "development"
  ActiveRecord::Base.logger = Logger.new(STDOUT) 
end 

require 'evaluations/evaluations'

require_all 'app/uploaders'
require_all 'app/models'
require_all 'app/serializers'

require 'api/api'