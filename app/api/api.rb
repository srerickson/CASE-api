require 'jwt'
require 'authorization_helpers'
require 'schemas'
require 'field_sets'

class API < Grape::API

  format :json

  before do
    header "Access-Control-Allow-Origin", "*"
  end


  desc "Returns JWT Token"
  params do 
    requires :username, type: String, desc: "Username"
    requires :password, type: String, desc: "Password"
  end
  post :authenticate do 
    if user = User.validate(params[:username],params[:password]) 
      profile = user.attributes.select { |key| ["_id", "email", "name","updated_at"].include? key }
      JWT.encode(profile, ENV["CASE_SECRET"]) 
    else
      error!('401 Unauthorized', 401)
    end
  end


  mount ::SchemasAPI
  mount ::FieldSetsAPI

end

