require 'jwt'
require 'authorization_helpers'
require 'cases'
require 'schemas'
require 'field_sets'

class API < Grape::API

  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers

  before do
    header "Access-Control-Allow-Origin", "*"
  end

  helpers AuthorizationHelpers


  desc "Returns JWT Token"
  params do 
    requires :username, type: String, desc: "Username"
    requires :password, type: String, desc: "Password"
  end
  post :authenticate do 
    if user = User.validate(params[:username],params[:password]) 
      JWT.encode(user.jwt_token, ENV["CASE_SECRET"],'HS256', {exp: 5.days.from_now.to_i}) 
    else
      error!('401 Unauthorized', 401)
    end
  end

  get :restricted do 
    authenticate!
    true
  end


  mount ::SchemasAPI
  mount ::FieldSetsAPI
  mount ::CasesAPI


end

