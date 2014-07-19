module CASE 
  class Uploads < Grape::API

    namespace :uploads do 

      desc "upload a file to a case"
      params do 
        requires :case_id
      end
      post do
        if @case and params[:case_image]
          @case.image = params[:case_image] 
          @case.save!
        elsif @case and params[:file]
          @case.uploads.create!(asset: params[:file])
        end
      end

    end
  end
end
