require 'field_definitions'

module CASE 
  class FieldSets < Grape::API

    helpers CASE::AuthorizationHelpers

    namespace :field_sets do

      after_validation do 
        @schema ||= Schema.find(params[:schema_id]) unless params[:schema_id].nil? 
      end

      desc "List Field Sets"
      get "/", each_serializer: CompactFieldSetSerializer do
        @schema.field_sets 
      end

      desc "Creates a new Field Set"
      post do 
        @schema.field_sets.create!(params[:field_set])
      end

      route_param :field_set_id do 

        desc "Show Field Set"
        get do
          @schema.field_sets.find(params[:field_set_id])
        end

        desc "Updates a Field Set"
        put do
          params[:field_set].delete(:field_definitions)
          @schema.field_sets.find(params[:field_set_id]).update_attributes!(params[:field_set])
        end

        desc "Destroys a Field Set"
        delete do
          @schema.field_sets.find(params[:field_set_id]).destroy!
        end

        mount CASE::FieldDefinitions

      end # route_param :field_set_id
    end # namespace :field_sets


  end
end
