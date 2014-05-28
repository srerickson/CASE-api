require 'jwt'

module AuthorizationHelpers

  def current_user
    begin
      @jwt_token ||= JWT.decode(headers['Authorization'], ENV['CASE_SECRET'])[0]
      @current_user ||= User.find(@jwt_token['_id'])
      # TODO: check that token and user params match?
      # TODO: Token expiration date
    rescue JWT::DecodeError
      nil
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end

  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end
end