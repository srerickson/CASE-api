require 'field_sets'

module CASE 
  class Schemas < Grape::API

    helpers CASE::AuthorizationHelpers

    namespace :schemas do

      desc "Lists Schemas."
      get "/", each_serializer: CompactSchemaSerializer do 
        Schema.all 
      end

      desc "Creates a Schema."
      post do 
        Schema.create! params[:schema]
      end

      route_param :schema_id do

        desc "Retrieves a Schema."
        get do
          Schema.find(params[:schema_id])
        end

        desc "Updates a Schema."
        put do
          Schema.find(params[:schema_id]).update_attributes!(params[:schema])
        end

        desc "Deletes a Schema."
        delete do
          Schema.find(params[:schema_id]).destroy!
        end

        mount CASE::FieldSets

      end # route_param :schema_id
    end # namespace :schemas

  end
end