class API < Grape::API

  format :json

  before do
    header "Access-Control-Allow-Origin", "*"
  end



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




  namespace :field_sets do

    desc "List Field Sets"
    get do 
      FieldSet.all
    end

    desc "Creates a new Field Set"
    post do 
      FieldSet.create(params[:field_set])
    end

    route_param :id do 

      desc "Show Field Set"
      get do
        FieldSet.find(params[:id])
      end

      desc "Updates a Field Set"
      put do
        FieldSet.find(params[:id]).update_attributes(params[:field_set])
      end

      desc "Destroys a Field Set"
      delete do
        FieldSet.find(params[:id]).destroy()
      end

      #
      # NESTED FIELD DEFINITIONS
      #
      namespace :field_definitions do

        desc "Creates a new Field Definition in the Field Set"
        post do 
          FieldSet.find(params[:id])
            .field_definitions.create(params[:field_definition])
        end

        route_param :field_definition_id do

          desc "Updates a Field Definition in the Field Set"
          put do
            FieldSet.find(params[:id])
              .field_definitions.find(params[:field_definition_id])
              .update_attributes(params[:field_definition])
          end

          desc "Destroys a Field Definition in the Field Set"
          delete do 
            FieldSet.find(params[:id])
              .field_definitions.find(params[:field_definition_id])
              .destroy()
          end

        end

      end # namespace :field_definitions
    end # route_param :id
  end # namespace :field_sets





  # post "/" do
  #   # All parameters will be stored in the model
  #   puts params
  #   thing = Thing.new(name: params[:name])
  #   if thing.save
  #     { thingId: thing.id }
  #   else
  #     error!({ errors: thing.errors.messages }, 403)
  #   end
  # end

end