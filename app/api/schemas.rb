class SchemasAPI < Grape::API

  namespace :schemas do

    desc "Lists Schemas."
    get do 
      Schema.all
    end

    desc "Creates a Schema."
    post do 
      Schema.create params[:schema]
    end

    route_param :id do

      desc "Retrieves a Schema."
      get do
        Schema.find(params[:id])
      end

      desc "Updates a Schema."
      put do
        Schema.find(params[:id]).update_attributes(params[:schema])
      end

      desc "Deletes a Schema."
      delete do
        Schema.find(params[:id]).destroy
      end

    end # route_param :id
  end # namespace :schemas

end
