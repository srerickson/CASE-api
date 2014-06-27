module CASE 
  class Uploads < Grape::API

    namespace :uploads do 

      desc "upload a file"
      post do
        CASE::API.logger.info params
      end

    end
  end
end
