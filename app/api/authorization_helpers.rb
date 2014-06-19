require 'jwt'

module CASE 
  module AuthorizationHelpers

    def current_user
      begin
        @jwt ||= JWT.decode(headers['Authorization'], ENV['CASE_SECRET'])
        uid = @jwt[0]['id']
        exp = @jwt[1]['exp']
        @current_user ||= User.find(uid)
        Time.now.to_i > exp ? nil : @current_user 
        
        # TODO: check that token and user params match?
        # TODO: Token expiration date
      rescue JWT::DecodeError
        nil
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end
  end

end