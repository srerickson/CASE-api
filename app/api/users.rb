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

    end
  end
end