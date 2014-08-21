module CASE 
  class FieldDefinitions < Grape::API

    helpers CASE::AuthorizationHelpers

    namespace :field_definitions do

      after_validation do 
        @schema ||= Schema.find(params[:schema_id])
      end

      desc "Creates a new Field Definition in the Field Set"
      post do
        # must be schema owner to do this
        authorize_owner!(@schema.user)

        @schema.field_sets.find(params[:field_set_id])
          .field_definitions.create!(params[:field_definition])
      end

      route_param :field_definition_id do

        desc "Gets a Field Definition in the Field Set"
        get do
          @schema.field_sets.find(params[:field_set_id])
                .field_definitions.find(params[:field_definition_id])
        end

        desc 'Gets the values for the field definition'
        get 'field_values' do 
          FieldValue.where(field_definition_id: params[:field_definition_id])
        end


        desc "Updates a Field Definition in the Field Set"
        put do
          # must be schema owner to do this
          authorize_owner!(@schema.user)

          @schema.field_sets.find(params[:field_set_id])
                .field_definitions.find(params[:field_definition_id])
                .update_attributes!(params[:field_definition])
        end

        desc "Destroys a Field Definition in the Field Set"
        delete do 
          # must be schema owner to do this
          authorize_owner!(@schema.user)

          @schema.field_sets.find(params[:field_set_id])
            .field_definitions.find(params[:field_definition_id])
            .destroy!
        end

      end

    end # namespace :field_definitions

  end
end