require 'field_sets'

module CASE 
  class Schemas < Grape::API

    helpers CASE::AuthorizationHelpers

    namespace :schemas do

      desc "Lists Schemas."
      get "/", each_serializer: CompactSchemaSerializer do
        schemas = Schema.all 
        if params[:own] and current_user
          schemas = schemas.where(user_id: current_user.id)
        end
        schemas 
      end

      desc "Creates a Schema."
      post do
        authenticate!
        params[:schema][:user_id] = current_user.id
        Schema.create! params[:schema]
      end

      route_param :schema_id do

        before do
          @schema = Schema.find(params[:schema_id])
        end

        desc "Retrieves a Schema."
        get do
          @schema
        end

        desc "Updates a Schema."
        put do
          authorize_owner!(@schema.user)
          # first delete params that were part of out-going JSON 
          # that should not be passed to update! 
          # (field set updates are handled in their own action)
          params[:schema].delete(:_case_count)
          params[:schema].delete(:field_sets)
          params[:schema].delete(:user)
          @schema.update_attributes!(params[:schema])
        end

        desc "Deletes a Schema."
        delete do
          authorize_owner!(@schema.user)
          @schema.destroy!
        end

        mount CASE::FieldSets

      end # route_param :schema_id
    end # namespace :schemas

  end
end