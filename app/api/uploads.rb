module CASE 
  class Uploads < Grape::API

    namespace :uploads do 

      desc "upload a file"
      post do
        if @case and params[:case_image]
          @case.image = params[:case_image] 
          @case.save!
        end
      end

    end
  end
end
