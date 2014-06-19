# This should be mounted by Schema

module CASE 
  class FieldSets < Grape::API

    helpers CASE::AuthorizationHelpers

    namespace :field_sets do

      # before do 
      #   authenticate!
      # end

      after_validation do 
        @schema = Schema.find(params[:schema_id]) unless params[:schema_id].nil? 
      end

      desc "List Field Sets"
      get "/", each_serializer: CompactFieldSetSerializer do 
        @schema.field_sets 
      end

      desc "Creates a new Field Set"
      post do 
        @schema.field_sets.create(params[:field_set])
      end

      route_param :field_set_id do 

        desc "Show Field Set"
        get do
          @schema.field_sets.find(params[:field_set_id])
        end

        desc "Updates a Field Set"
        put do
          @schema.field_sets.find(params[:field_set_id]).update_attributes(params[:field_set])
        end

        desc "Destroys a Field Set"
        delete do
          @schema.field_sets.find(params[:field_set_id]).destroy()
        end

        #
        # NESTED FIELD DEFINITIONS
        #
        namespace :field_definitions do

          desc "Creates a new Field Definition in the Field Set"
          post do 
            @schema.field_sets.find(params[:field_set_id])
              .field_definitions.create!(params[:field_definition])
          end

          route_param :field_definition_id do

            desc "Updates a Field Definition in the Field Set"
            put do
              @schema.field_sets.find(params[:field_set_id])
                .field_definitions.find(params[:field_definition_id])
                .update_attributes(params[:field_definition])
            end

            desc "Destroys a Field Definition in the Field Set"
            delete do 
              @schema.field_sets.find(params[:field_set_id])
                .field_definitions.find(params[:field_definition_id])
                .destroy()
            end

          end

        end # namespace :field_definitions
      end # route_param :field_set_id
    end # namespace :field_sets


  end
end
