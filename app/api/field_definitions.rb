module CASE 
  class FieldDefinitions < Grape::API

    helpers CASE::AuthorizationHelpers

    namespace :field_definitions, root: :field_definitions do

      after_validation do 
        @schema ||= Schema.find(params[:schema_id]) unless params[:schema_id].nil? 
      end

      desc "Creates a new Field Definition in the Field Set"
      post do 
        @schema.field_sets.find(params[:field_set_id])
          .field_definitions.create!(params[:field_definition])
      end

      route_param :field_definition_id do

        desc "Gets a Field Definition in the Field Set"
        get do
          @schema.field_sets.find(params[:field_set_id])
                .field_definitions.find(params[:field_definition_id])
        end

        desc "Updates a Field Definition in the Field Set"
        put do
          @schema.field_sets.find(params[:field_set_id])
                .field_definitions.find(params[:field_definition_id])
                .update_attributes!(params[:field_definition])
        end

        desc "Destroys a Field Definition in the Field Set"
        delete do 
          @schema.field_sets.find(params[:field_set_id])
            .field_definitions.find(params[:field_definition_id])
            .destroy!
        end

      end

    end # namespace :field_definitions

  end
end