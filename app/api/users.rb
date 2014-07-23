module CASE 
  class Users < Grape::API

    helpers CASE::AuthorizationHelpers

    namespace :users do

      before do
        authenticate!
      end

      get 'current_user' do
        current_user 
      end

      route_param :user_id do

        params do
          requires :user
        end
        put do 
          user = User.validate(current_user.email, params[:user][:current_password] )

          CASE::API.logger.info user
          CASE::API.logger.info current_user
          CASE::API.logger.info user==current_user

          if user and user == current_user
            params[:user].delete(:current_password)
            params[:user].delete(:configs)
            return user.update_attributes!(params[:user])
          else
            error!('Bad Password', 500)
          end
        end
      end

    end
  end
end