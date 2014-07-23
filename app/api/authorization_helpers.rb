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
        updated_at = @jwt[0]['updated_at']
        exp = @jwt[1]['exp']

        @current_user ||= User.find(uid)

        return nil if Time.now.to_i > exp
        return nil if @current_user.updated_at.to_i != Time.parse(updated_at).to_i

        @current_user 
        

      rescue JWT::DecodeError
        nil
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end

    def authorize_owner!(user)
     error!('401 Unauthorized', 401) unless current_user and current_user == user
    end

  end

end