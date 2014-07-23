require 'compact_case_serializer'

module CASE
  module Evaluations
    class Sets < Grape::API

      namespace :sets do

        desc "Gets all evaluation sets"
        get "/", each_serializer: CompactSetSerializer do 
          Set.all 
        end

        desc "Creates an evaluation set"
        params do
          requires :set
        end
        post do
          authenticate!
          params[:set][:user_id] = current_user.id
          Set.create!(params[:set])
        end

        route_param :set_id do 

          before do 
            if params[:set_id] == "first"
              @set = Set.first
            end
            @set ||= Set.find(params[:set_id])
          end

          desc "Gets an evaluation set"
          get do
            @set
          end

          desc "Updates an evaluation set"
          params do
            requires :set
          end
          put do
            authorize_owner!(@set.user)
            params[:set].delete(:questions)
            @set.update_attributes!(params[:set])
          end

          desc "Destroys and evaluation set"
          delete do
            authorize_owner!(@set.user)
            @set.destroy! 
          end 

          mount CASE::Evaluations::Responses
          mount CASE::Evaluations::Questions

        end

      end
      
    end

  end
end