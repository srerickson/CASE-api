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

    #
    # SINGLE SCHEMA ROUTES
    #
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

      #
      # NESTED FIELD SET ROUTES
      #
      namespace :field_sets do

        desc "Creates a new Field Set in the Schema"
        post do 
          schema = Schema.find(params[:id])
          schema.field_set.create(params[:field_set])
        end

        route_param :field_set_id do 

          desc "Updates a Schema's Field Set"
          put do
            Schema.find(params[:id])
              .field_sets.find(params[:field_set_id])
              .update_attributes(params[:field_set])
          end

          desc "Destroys a Schema's Field Set"
          delete do
            Schema.find(params[:id])
              .field_sets.find(params[:field_set_id])
              .destroy()
          end

          #
          # NESTED FIELD DEFINITIONS
          #
          namespace :field_definitions do

            desc "Creates a new Field Definition in the Schema's Field Set"
            post do 
              Schema.find(params[:id])
                .field_sets.find(params[:field_set_id])
                .field_definitions.create!(params[:field_definition])
            end

            route_param :field_definition_id do

              desc "Updates a Field Definition in the Schema's Field Set"
              put do
                Schema.find(params[:id])
                      .field_sets.find(params[:field_set_id])
                      .field_definitions.find(params[:field_definition_id])
                      .update_attributes(params[:field_definition])
              end

              desc "Destroys a Field Definition in the Schema's Field Set"
              delete do 
                Schema.find(params[:id])
                  .field_sets.find(params[:field_set_id])
                  .field_definitions.find(params[:field_definition_id])
                  .destroy()
              end

            end

          end # namespace :field_definitions
        end # route_param :field_set_id
      end # namespace :field_sets
    end # route_param :id
  end # namespace :schemas




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