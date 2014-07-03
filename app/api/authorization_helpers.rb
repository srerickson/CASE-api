require 'jwt'

module CASE 
  module AuthorizationHelpers

    def white_list
      [
        [/POST/, /\/authenticate/],
        [/GET/, /.*/]
      ]
    end

    def need_authorization?(route)
      method = route.route_method
      path = route.route_path.gsub(/\(\.:format\)/,'')
      white_listed = white_list.any? do |pattern|
        method =~ pattern[0] and path =~ pattern[1]
      end
      if white_listed
        false
      else
        true
      end
    end      

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