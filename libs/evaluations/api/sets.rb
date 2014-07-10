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
          Set.create!(params[:set])
        end

        route_param :set_id do 

          before do 
            @set = Set.find(params[:set_id])
          end

          desc "Gets an evaluation set"
          get do 
            @set
          end

          desc "Gets cases evaluated with the evaluation set"
          get :cases, each_serializer: ::CompactCaseSerializer, root: :cases do 
            @set.cases
          end

          desc "Updates an evaluation set"
          params do
            requires :set
          end
          put do 
            @set.update_attributes!(params[:set])
          end

          desc "Destroys and evaluation set"
          delete do 
            @set.destroy! 
          end 

          mount CASE::Evaluations::Questions
        end

      end
      
    end

  end
end