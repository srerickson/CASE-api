require 'jwt'
require 'authorization_helpers'
require 'cases'
require 'schemas'

module CASE
  class API < Grape::API

    ActiveRecord::Base.logger = Logger.new(STDOUT)

    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    before do
      CASE::API.logger.info "#{route.route_path}"
    end

    helpers CASE::AuthorizationHelpers

    desc "Returns JWT Token"
    params do 
      requires :username, type: String, desc: "Username"
      requires :password, type: String, desc: "Password"
    end
    post :authenticate do 
      if user = User.validate(params[:username],params[:password]) 
        token = JWT.encode(user.jwt_token, ENV["CASE_SECRET"],'HS256', {exp: 5.days.from_now.to_i})
        return {token: token}
      else
        error!('401 Unauthorized', 401)
      end
    end

    get :restricted do 
      authenticate!
      return {response: "success"}
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      Rack::Response.new({ error: e.message }.to_json, 404).finish
    end 

    rescue_from ActiveRecord::RecordInvalid do |e|
      Rack::Response.new({ error: e.message }.to_json, 500).finish
    end

    rescue_from ActiveRecord::RecordNotSaved do |e|
      Rack::Response.new({ error: e.message }.to_json, 500).finish
    end

    mount CASE::Schemas
    mount CASE::Cases

  end
end
