require 'uploads'

module CASE
  class Cases < Grape::API

    helpers CASE::AuthorizationHelpers

    namespace :cases do

      # before do 
      #   authenticate!
      # end

      desc "List Cases"
      get do 
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
        put do
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
          post do
            @case.field_values.create!(params[:field_value])
          end

          route_param :field_value_id do

            desc "Updates a Field Value in the Case"
            put do
              @case.field_values.find(params[:field_value_id])
                .update_attributes!(params[:field_value])
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