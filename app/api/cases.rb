require 'uploads'

module CASE
  class Cases < Grape::API

    helpers CASE::AuthorizationHelpers

    namespace :cases do

      # before do 
      #   authenticate!
      # end

      desc "List Cases"
      get "/", each_serializer: CompactCaseSerializer do
        Case.all
      end

      desc "Creates a new Case"
      post do 
        Case.create!(params[:case])
      end

      route_param :case_id do 

        before do 
          @case = Case.find(params[:case_id])
        end

        desc "Show Case"
        get do
          @case
        end

        desc "Updates a Case"
        params do
          requires :case
        end
        put do
          params[:case].delete(:_image_urls)
          @case.update_attributes!(params[:case])
        end

        desc "Destroys a Case"
        delete do
          @case.destroy!
        end

        mount CASE::Uploads

        #
        # NESTED FIELD VALUES
        #
        namespace :field_values do

          desc "List Case's Field Values (optionally limited to a particular schema)"
          get do 
            if params[:schema_id]
              @schema = Schema.find(params[:schema_id])
              @schema.field_values.where(case_id: params[:case_id])
            else
              @case.field_values
            end
          end

          desc "Creates a new Field Value in the Case"
          params do 
            requires :field_value, type: Hash do
              requires :field_definition_id
            end
          end
          post do
            params[:field_value][:case_id] = params[:case_id]
            fd = FieldDefinition.find(params[:field_value][:field_definition_id])
            fd.class.value_class.create!(params[:field_value])
          end

          route_param :field_value_id do

            desc "Updates a Field Value in the Case"
            put do                
              fv = @case.field_values.find(params[:field_value_id])
              fv.update_attributes!(params[:field_value])
              fv.reload
            end

            desc "Destroys a Field Value in the Case"
            delete do 
              @case.field_values.find(params[:field_value_id])
                .destroy!
            end

          end

        end # namespace :field_values
      end # route_param :id
    end # namespace :cases


  end
end