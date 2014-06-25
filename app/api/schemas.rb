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
          # first delete params that were part of out-going JSON 
          # that should not be passed to update! 
          # (field set updates are handled in their own action)
          params[:schema].delete(:_case_count)
          params[:schema].delete(:field_sets)
          Schema.find(params[:schema_id]).update_attributes!(params[:schema])
        end

        desc "Deletes a Schema."
        delete do
          Schema.find(params[:schema_id]).destroy!
        end

        mount CASE::FieldSets

        namespace :cases do
          desc "Gets a list of cases that use the schema."
          get do 
            Schema.find(params[:schema_id]).cases.order(:name)
          end
        end # namespace :cases

      end # route_param :schema_id
    end # namespace :schemas

  end
end